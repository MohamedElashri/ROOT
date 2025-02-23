# ROOT for Google Colab

This repository provides optimized ROOT binaries specifically for Google Colab environments. It aims to simplify the process of using ROOT in Colab notebooks by providing lightweight, ready-to-use builds that match Colab's Python versions.

## 🎯 Purpose

Google Colab frequently updates its runtime environment, which can break ROOT installations. This repository automatically builds and provides compatible ROOT versions for different Python versions, ensuring you can always use ROOT in your Colab notebooks.

## 🔧 Available Builds

The following ROOT versions are available:
- ROOT 6.30.04
- ROOT 6.32.04

Each ROOT version is built for Python versions:
- Python 3.11
- Python 3.12

## 📊 Version Compatibility Matrix

| Colab Python Version | Recommended ROOT Version | Download Link Template |
|---------------------|-------------------------|----------------------|
| 3.11 | 6.32.04 | `root_v6.32.04_Ubuntu_Python3.11.zip` |
| 3.12 | 6.32.04 | `root_v6.32.04_Ubuntu_Python3.12.zip` |

## 📥 Available Downloads

| ROOT Version | Python Version | Download Link |
|-------------|----------------|---------------|
| 6.30.04 | 3.11 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/root-v6.30.04-python3.11/root_v6.30.04_Ubuntu_Python3.11.zip) |
| 6.30.04 | 3.12 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/root-v6.30.04-python3.12/root_v6.30.04_Ubuntu_Python3.12.zip) |
| 6.32.04 | 3.11 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/root-v6.32.04-python3.11/root_v6.32.04_Ubuntu_Python3.11.zip) |
| 6.32.04 | 3.12 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/root-v6.32.04-python3.12/root_v6.32.04_Ubuntu_Python3.12.zip) |

## 🚀 Quick Start

1. First, check your Colab Python version:
```python
!python --version
```

2. Download and install the appropriate ROOT build:
```python
# Example for Python 3.11 with ROOT 6.32.04
!wget https://github.com/MohamedElashri/ROOT/releases/download/root-v6.32.04-python3.11/root_v6.32.04_Ubuntu_Python3.11.zip
!unzip root_v6.32.04_Ubuntu_Python3.11.zip -d /usr/local
!rm root_v6.32.04_Ubuntu_Python3.11.zip
```

3. Set up the environment:
```python
import os
os.environ['ROOTSYS'] = '/usr/local'
os.environ['PATH'] = f"{os.environ['ROOTSYS']}/bin:" + os.environ['PATH']
os.environ['LD_LIBRARY_PATH'] = f"{os.environ['ROOTSYS']}/lib:" + os.environ.get('LD_LIBRARY_PATH', '')
os.environ['PYTHONPATH'] = f"{os.environ['ROOTSYS']}/lib:" + os.environ.get('PYTHONPATH', '')
```

4. Import ROOT and verify installation:
```python
import ROOT
print(ROOT.gROOT.GetVersion())
```

## 📋 Example Usage

Here's a complete example for current Colab (Python 3.11):

```python
# Check Python version
!python --version

# Install ROOT
!wget https://github.com/MohamedElashri/ROOT/releases/download/root-v6.32.04-python3.11/root_v6.32.04_Ubuntu_Python3.11.zip
!unzip root_v6.32.04_Ubuntu_Python3.11.zip -d /usr/local
!rm root_v6.32.04_Ubuntu_Python3.11.zip

# Set environment variables
import os
os.environ['ROOTSYS'] = '/usr/local'
os.environ['PATH'] = f"{os.environ['ROOTSYS']}/bin:" + os.environ['PATH']
os.environ['LD_LIBRARY_PATH'] = f"{os.environ['ROOTSYS']}/lib:" + os.environ.get('LD_LIBRARY_PATH', '')
os.environ['PYTHONPATH'] = f"{os.environ['ROOTSYS']}/lib:" + os.environ.get('PYTHONPATH', '')

# Import ROOT and create a simple histogram
import ROOT
h = ROOT.TH1F("gauss","Example histogram",100,-4,4)
h.FillRandom("gaus")
h.Draw()
```

## 🛠 Build Features

These optimized ROOT builds include essential features for data analysis:

**Included Components**:
- ✅ Python bindings (PyROOT)
- ✅ RooFit statistical analysis package
- ✅ MathMore libraries
- ✅ Multithreading support (IMT)
- ✅ SSL and XML support
- ✅ XRootD support (built-in)
- ✅ ROOT 7 features
- ✅ 3D Graphics (graf3d)
- ✅ PYTHIA8 integration
- ✅ Fortran support
- ✅ Thread support

**Excluded for Optimization**:
- ❌ OpenGL support
- ❌ Vector Detection Technology (VDT)
- ❌ SQLite support
- ❌ GDML support
- ❌ Davix
- ❌ FITS I/O
- ❌ Table support
- ❌ Testing modules
- ❌ Debug symbols (using MinSizeRel build)

## ⚠️ Known Issues

1. If you encounter SSL-related errors:
```python
!wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
!sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
!rm libssl1.1_1.1.1f-1ubuntu2_amd64.deb
```

2. If ROOT fails to import after installation, try restarting your Colab runtime

3. If you need any of the excluded features, You will need to build ROOT with them

***Building ROOT in the same colab runtime will take most of the runtime allocation time because it takes long time to build***

5. If you encounter any issues, please open a new issue on this repository

## 🙏 Acknowledgments

- CERN ROOT team for the amazing ROOT framework
- Google Colab team for providing free GPU resources
- All contributors and users of this project
