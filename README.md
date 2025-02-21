# ROOT for Google Colab

This repository provides pre-built ROOT binaries specifically for Google Colab environments. It aims to simplify the process of using ROOT in Colab notebooks by providing ready-to-use builds that match Colab's Python versions.

## 🎯 Purpose

Google Colab frequently updates its runtime environment, which can break ROOT installations. This repository automatically builds and provides compatible ROOT versions for different Python versions, ensuring you can always use ROOT in your Colab notebooks.

## 🔧 Available Builds

The following ROOT versions are available:
- ROOT 6.30.04
- ROOT 6.32.04
- ROOT 6.34.04

Each ROOT version is built for Python versions:
- Python 3.10
- Python 3.11
- Python 3.12
- Python 3.13

## 📊 Version Compatibility Matrix

| Colab Python Version | Recommended ROOT Version | Download Link Template |
|---------------------|-------------------------|----------------------|
| 3.10 | 6.30.04 | `root_v6.30.04_Ubuntu_Python3.10.tar.gz` |
| 3.11 | 6.32.04 | `root_v6.32.04_Ubuntu_Python3.11.tar.gz` |
| Future versions | 6.34.04 | `root_v6.34.04_Ubuntu_Python{version}.tar.gz` |

## 📥 Available Downloads

| ROOT Version | Python Version | Download Link |
|-------------|----------------|---------------|
| 6.30.04 | 3.10 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/v6.30.04-py3.10/root_v6.30.04_Ubuntu_Python3.10.tar.gz) |
| 6.30.04 | 3.11 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/v6.30.04-py3.11/root_v6.30.04_Ubuntu_Python3.11.tar.gz) |
| 6.30.04 | 3.12 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/v6.30.04-py3.12/root_v6.30.04_Ubuntu_Python3.12.tar.gz) |
| 6.30.04 | 3.13 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/v6.30.04-py3.13/root_v6.30.04_Ubuntu_Python3.13.tar.gz) |
| 6.32.04 | 3.10 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/v6.32.04-py3.10/root_v6.32.04_Ubuntu_Python3.10.tar.gz) |
| 6.32.04 | 3.11 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/v6.32.04-py3.11/root_v6.32.04_Ubuntu_Python3.11.tar.gz) |
| 6.32.04 | 3.12 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/v6.32.04-py3.12/root_v6.32.04_Ubuntu_Python3.12.tar.gz) |
| 6.32.04 | 3.13 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/v6.32.04-py3.13/root_v6.32.04_Ubuntu_Python3.13.tar.gz) |
| 6.34.04 | 3.10 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/v6.34.04-py3.10/root_v6.34.04_Ubuntu_Python3.10.tar.gz) |
| 6.34.04 | 3.11 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/v6.34.04-py3.11/root_v6.34.04_Ubuntu_Python3.11.tar.gz) |
| 6.34.04 | 3.12 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/v6.34.04-py3.12/root_v6.34.04_Ubuntu_Python3.12.tar.gz) |
| 6.34.04 | 3.13 | [Download](https://github.com/MohamedElashri/ROOT/releases/download/v6.34.04-py3.13/root_v6.34.04_Ubuntu_Python3.13.tar.gz) |

## 🚀 Quick Start

1. First, check your Colab Python version:
```python
!python --version
```

2. Download and install the appropriate ROOT build:
```python
# Example for Python 3.11 with ROOT 6.32.04
!wget https://github.com/MohamedElashri/ROOT/releases/download/v6.32.04-py3.11/root_v6.32.04_Ubuntu_Python3.11.tar.gz
!tar -xzf root_v6.32.04_Ubuntu_Python3.11.tar.gz -C /usr/local
!rm root_v6.32.04_Ubuntu_Python3.11.tar.gz
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
!wget https://github.com/MohamedElashri/ROOT/releases/download/v6.32.04-py3.11/root_v6.32.04_Ubuntu_Python3.11.tar.gz
!tar -xzf root_v6.32.04_Ubuntu_Python3.11.tar.gz -C /usr/local
!rm root_v6.32.04_Ubuntu_Python3.11.tar.gz

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
c = ROOT.TCanvas("myCanvasName","The Canvas Title",800,600)
h.Draw()
c.Draw()
```

## 🔄 Version Updates

When Google Colab updates its Python version:

1. Check your new Python version:
```python
!python --version
```

2. Select the appropriate ROOT build from the releases page that matches your Python version
3. Update your installation commands accordingly

## 🛠 Build Features

These ROOT builds include:
- Python bindings (PyROOT)
- RooFit for statistical analysis
- Multithreading support
- OpenGL visualization
- Web-based display support
- GSL integration
- Math libraries (mathmore)
- SSL and XML support

## ⚠️ Known Issues

1. If you encounter SSL-related errors:
```python
!wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
!sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
!rm libssl1.1_1.1.1f-1ubuntu2_amd64.deb
```

2. If ROOT fails to import after installation, try restarting your Colab runtime

3. If you encounter any issues, please open a new issue on this repository

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- CERN ROOT team for the amazing ROOT framework
- Google Colab team for providing free GPU resources
- All contributors and users of this project

