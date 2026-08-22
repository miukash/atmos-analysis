# Atmos Analysis

Docker-based analysis environment for Atmos telemetry data.

The environment includes HEASoft and the tools required for FITS data analysis.

---

## Architecture

```text
                         WSL 2
                           │
                    ┌──────┴──────┐
                    │             │
                  data/        VS Code
                    │             │
                    │             │ Dev Containers
                    │             ▼
                    │      Docker Container
                    │             │
                    │         /workspace
                    │             │
                    │      ┌──────┴──────┐
                    │      │             │
                    │    FTOOLS        XSPEC
                    │
                    └──────► /workspace/data
```

FITS files are stored in the WSL `data/` directory.

The project directory is mounted into the Docker container when using VS Code Dev Containers.

The Docker image contains:

- HEASoft
- FTOOLS
- XSPEC
- Python
- Required Python packages

---

# Prerequisites

- Windows
- WSL 2
- Docker Desktop
- VS Code
- VS Code Dev Containers extension
- Windows FITS Viewer

Docker Desktop is recommended when using Docker from WSL.

Verify Docker:

```bash
docker --version
```

Verify WSL:

```bash
wsl --version
```

---

# Getting Started

## 1. Clone the Repository

From WSL:

```bash
git clone <repository-url>

cd atmosdemo/atmos_platform/atmos_analysis
```

---

## 2. Prepare Data

Place the FITS files under the `data/` directory.

For example:

```text
atmos_analysis/

├── data/
│   ├── example1.fits
│   └── example2.fits
├── .devcontainer/
│   └── devcontainer.json
├── Dockerfile
├── Makefile
├── README.md
├── requirements.txt
└── tests/
```

The data itself is not included in this repository.

---

## 3. Get the Analysis Image

Pull the pre-built Docker image:

```bash
make pull
```

The image contains:

- HEASoft
- FTOOLS
- XSPEC
- Python
- Required Python packages

---

## 4. Test the Analysis Environment

Run:

```bash
make test
```

The test checks that the required analysis environment is available inside the Docker image.

A successful test should finish without errors.

---

# Development with VS Code

The recommended way to use the analysis environment is **VS Code Dev Containers**.

This allows the project files to be edited in VS Code while the analysis tools run inside the Docker container.

## 1. Open the Project

From WSL:

```bash
code .
```

---

## 2. Open the Project in the Container

In VS Code:

```text
Ctrl + Shift + P
```

Select:

```text
Dev Containers: Reopen in Container
```

VS Code will start the `atmos-analysis:v1.0` Docker image and connect to it.

The VS Code Explorer will show:

```text
/workspace/

├── Dockerfile
├── Makefile
├── README.md
├── data/
├── requirements.txt
└── tests/
```

The VS Code terminal will also run inside the Docker container:

```text
root@<container>:/workspace#
```

You can then use the analysis tools directly.

For example:

```bash
fversion
```

```bash
ftlist /workspace/data/example1.fits K
```

```bash
fkeyprint /workspace/data/example1.fits SIMPLE
```

Python is also available:

```bash
python
```

The FITS files in `data/` are accessible from the container through:

```text
/workspace/data/
```

---

# FITS Files

There are two ways to view FITS files depending on the WSL environment.

## Option 1: WSLg is available

If WSLg is available, `fv` can be run inside the Docker container and displayed on the Windows desktop.

Start the GUI-enabled environment:

```bash
make fv
```

Then inside the container:

```bash
fv /workspace/data/example1.fits
```

The architecture is:

```text
Windows
   │
   │ WSLg
   ▼
WSL 2
   │
   ▼
Docker Container
   │
   ▼
HEASoft / fv
   │
   ▼
Windows GUI
```

---

## Option 2: WSLg is not available

If `fv` cannot display its GUI, use **Windows FV** to open the FITS file.

The FITS files remain in the WSL `data/` directory.

Windows can access the WSL filesystem through:

```text
\\wsl.localhost\
```

For example:

```text
\\wsl.localhost\Ubuntu\home\<user>\proj\atmosdemo\atmos_platform\atmos_analysis\data\
```

Open Windows Explorer and navigate to the `data/` directory.

Then open the FITS file using the Windows FITS Viewer.

The same FITS file is accessed from both environments:

```text
                         test.fits
                             │
                ┌────────────┴────────────┐
                │                         │
             WSL/Docker                Windows
                │                         │
                ▼                         ▼
         HEASoft / FTOOLS          Windows FITS Viewer
```

The FITS file does not need to be copied from WSL to Windows.

---

# Command Line Environment

If VS Code is not required, the Docker environment can also be started directly.

```bash
make shell
```

This starts an interactive shell inside the Docker container.

The WSL `data/` directory is mounted to:

```text
/workspace/data/
```

For example:

```bash
ls /workspace/data
```

and:

```bash
fversion
```

can be used to verify the environment.

---

# Make Commands

| Command | Description |
|---|---|
| `make pull` | Pull the pre-built Analysis Docker image |
| `make build` | Build the Analysis Docker image locally |
| `make test` | Test the Analysis environment |
| `make shell` | Start an interactive Docker shell with `data/` mounted |
| `make fv` | Start the GUI-enabled Docker environment for `fv` |

---

# Build the Image Locally

If you need to build the Docker image locally:

```bash
make build
```

This creates:

```text
atmos-analysis:v1.0
```

---

# Project Structure

```text
atmos_analysis/

├── .devcontainer/
│   └── devcontainer.json
├── Dockerfile
├── Makefile
├── README.md
├── requirements.txt
├── tests/
└── data/
```

The `data/` directory contains local analysis data and is not included in the Git repository.

---

# Typical Workflow

The recommended workflow is:

```text
1. Start WSL
       │
       ▼
2. cd atmos_analysis
       │
       ▼
3. code .
       │
       ▼
4. Reopen in Container
       │
       ▼
5. Analyze FITS data
       │
       ├── FTOOLS
       ├── XSPEC
       └── Python
```

For FITS visualization:

```text
WSLg available
    │
    └── make fv
           │
           └── fv → Windows GUI


WSLg unavailable
    │
    └── Windows Explorer
           │
           └── Windows FITS Viewer
```

The analysis environment itself does not depend on `fv`. If the GUI is unavailable, HEASoft, FTOOLS, XSPEC, and Python can still be used inside the Docker container.