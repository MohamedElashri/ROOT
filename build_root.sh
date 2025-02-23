#!/bin/bash
# =============================================================================
# Script: build_root.sh
#
# Description:
#   Parameterized script to build ROOT for specified versions of ROOT and Python
#
# Usage:
#   ./build_root.sh <python_version> <root_version>
# =============================================================================

set -e

# Define color codes for colorful output
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NC="\033[0m"  # No Color

# Logging functions
info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}
success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}
error() {
  echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Trap unexpected errors
trap 'error "An unexpected error occurred at line $LINENO. Exiting."' ERR

# Parse command line arguments
if [ "$#" -ne 2 ]; then
    error "Usage: $0 <python_version> <root_version>"
    exit 1
fi

PYTHON_VERSION="$1"
ROOT_VERSION="$2"

# Validate inputs
if [[ ! $PYTHON_VERSION =~ ^[0-9]+\.[0-9]+$ ]]; then
    error "Invalid Python version format. Expected format: X.Y"
    exit 1
fi

if [[ ! $ROOT_VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    error "Invalid ROOT version format. Expected format: X.Y.Z"
    exit 1
fi

# Default: use all available cores
DEFAULT_CORES=$(nproc)
CORES_TO_USE=$DEFAULT_CORES

# Define installation paths
INSTALL_DIR="root_build"
PACKAGE_FILE="artifacts/root_v${ROOT_VERSION}_Ubuntu_Python${PYTHON_VERSION}.zip"

info "Building ROOT ${ROOT_VERSION} with Python ${PYTHON_VERSION}"
info "Using ${CORES_TO_USE} cores for building."

# Add repository for additional dependencies
info "Adding additional repositories..."
sudo add-apt-repository -y universe
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test

# Install dependencies
info "Installing required dependencies..."
sudo apt-get update || { error "Failed to update package lists."; exit 1; }
sudo apt-get install -y software-properties-common ninja-build zip \
  dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev \
  libssl-dev libpcre3-dev libgsl-dev gfortran tar wget \
  python${PYTHON_VERSION} python${PYTHON_VERSION}-venv python${PYTHON_VERSION}-dev jq xz-utils \
  libpython${PYTHON_VERSION}-dev libgif-dev libjpeg-dev libtiff-dev libgl1-mesa-dev libglu1-mesa-dev \
  libc6-dev libstdc++-9-dev libtinfo-dev || { error "Failed to install dependencies."; exit 1; }

success "Dependencies installed."

# Set up Python virtual environment
info "Setting up Python ${PYTHON_VERSION} virtual environment..."
if [ -d "venv" ]; then
  rm -rf venv
fi
python${PYTHON_VERSION} -m venv venv || { error "Failed to create virtual environment."; exit 1; }
source venv/bin/activate || { error "Failed to activate virtual environment."; exit 1; }
pip install --upgrade pip numpy || { error "Failed to install NumPy."; exit 1; }
success "Python virtual environment is ready."

# Set Python-related environment variables
info "Configuring Python environment variables..."
PYTHON_PATH=$(which python)
PYTHON_LIBRARY=$(python -c 'import sysconfig; print(sysconfig.get_config_var("LIBDIR") + "/lib" + sysconfig.get_config_var("LDLIBRARY"))') \
  || { error "Failed to get Python library path."; exit 1; }
PYTHON_INCLUDE_DIR=$(python -c 'import sysconfig; print(sysconfig.get_config_var("INCLUDEPY"))') \
  || { error "Failed to get Python include directory."; exit 1; }
NUMPY_INCLUDE_DIR=$(python -c 'import numpy; print(numpy.get_include())') \
  || { error "Failed to get NumPy include directory."; exit 1; }
success "Python environment variables set."

# Download and extract ROOT source code
info "Downloading ROOT version ${ROOT_VERSION}..."
ROOT_TAR="root_v${ROOT_VERSION}.source.tar.gz"
ROOT_URL="https://root.cern/download/${ROOT_TAR}"

if [ -f "${ROOT_TAR}" ]; then
  rm "${ROOT_TAR}"
fi

wget ${ROOT_URL} || { error "Failed to download ROOT source."; exit 1; }

if [ -d "root-${ROOT_VERSION}" ]; then
  rm -rf "root-${ROOT_VERSION}"
fi

info "Extracting ROOT source..."
tar -xzf ${ROOT_TAR} || { error "Failed to extract ROOT source."; exit 1; }
success "ROOT source extracted."

# Create and enter the build directory
info "Creating build directory..."
rm -rf build
mkdir -p build || { error "Failed to create build directory."; exit 1; }
cd build || { error "Failed to enter build directory."; exit 1; }

# Configure CMake
info "Configuring CMake build..."
cmake ../root-${ROOT_VERSION} \
  -DCMAKE_INSTALL_PREFIX="../${INSTALL_DIR}" \
  -DCMAKE_BUILD_TYPE=MinSizeRel \
  -DPYTHON_EXECUTABLE=${PYTHON_PATH} \
  -DCMAKE_CXX_FLAGS="-fPIC -D_GLIBCXX_USE_CXX11_ABI=1" \
  -DCMAKE_C_FLAGS="-fPIC" \
  -DCMAKE_CXX_STANDARD=17 \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
  -DCMAKE_INSTALL_RPATH="${PWD}/../${INSTALL_DIR}/lib" \
  -DCMAKE_FIND_LIBRARY_SUFFIXES=".a;.so" \
  -Dpyroot=ON \
  -Dmathmore=ON \
  -Droofit=ON \
  -Dthread=ON \
  -Dssl=ON \
  -Dxml=ON \
  -Dxrootd=ON \
  -Dbuiltin_xrootd=ON \
  -Dbuiltin_ftgl=ON \
  -Dbuiltin_glew=ON \
  -Dbuiltin_afterimage=ON \
  -Dbuiltin_ryml=ON \
  -Dbuiltin_vdt=OFF \
  -Dvdt=OFF \
  -Dopengl=OFF \
  -Dvc=OFF \
  -Dimt=ON \
  -Dccache=OFF \
  -Dtesting=OFF \
  -Droot7=ON \
  -Dtable=OFF \
  -Dsqlite=OFF \
  -Dgraf3d=ON \
  -Dgdml=OFF \
  -Ddavix=OFF \
  -Dfitsio=OFF \
  -Dfortran=ON \
  -Dpythia8=ON \
  -G Ninja || { error "CMake configuration failed."; exit 1; }

success "CMake configuration completed."

# Build and install ROOT
info "Building ROOT with Ninja..."
VERBOSE=1 ninja -j${CORES_TO_USE} || { error "Build failed."; exit 1; }
success "ROOT built successfully."

info "Installing ROOT..."
ninja install || { error "Installation failed."; exit 1; }
success "ROOT installed successfully."

# Package ROOT installation
cd ..
mkdir -p artifacts

info "Packaging ROOT installation into ZIP..."
zip -r ${PACKAGE_FILE} root_build/ || { error "Failed to package ROOT."; exit 1; }
success "ROOT packaged successfully."

info "Final package size:"
ls -lh ${PACKAGE_FILE} || { error "Failed to retrieve package size."; exit 1; }

success "Build script completed successfully."
