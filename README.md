# Atmos Analysis

Docker-based analysis environment for Atmos telemetry data.

The environment includes HEASoft and the tools required for FITS data analysis.

---

## Architecture

```text
                    WSL
                     │
              ┌──────┴──────┐
              │             │
           data/          VS Code
              │
              │ mount
              ▼
        Docker Container
              │
       /workspace/data
              │
        ┌─────┴─────┐
        │           │
     FTOOLS       XSPEC
```

FITS files are stored in WSL and mounted into the Docker container.

FITS files can also be opened using a FITS viewer installed on Windows.

---

# Prerequisites

* Docker
* WSL 2
* VS Code
* Windows FITS Viewer

Docker Desktop is recommended when using Docker from WSL.

Verify Docker:

```bash
docker --version
```

---

# Getting Started

## 1. Clone the Repository

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
├── Dockerfile
├── Makefile
└── ...
```

The data itself is not included in this repository.

---

## 3. Get the Analysis Image

Pull the pre-built Docker image:

```bash
make pull
```

The image contains:

* HEASoft
* FTOOLS
* XSPEC
* Python
* Required Python packages

---

## 4. Test the Analysis Environment

Run:

```bash
make test
```

The test checks that the required analysis environment is available inside the Docker image.

A successful test should finish without errors.

---

## 5. Start the Analysis Environment

Run:

```bash
make shell
```

This starts an interactive shell inside the Docker container.

The WSL `data/` directory is mounted automatically:

```text
WSL:

atmos_analysis/data/
        │
        │ bind mount
        ▼
Docker:

/workspace/data/
```

Inside the container:

```bash
ls /workspace/data
```

You should see the FITS files stored in `data/`.

For example:

```bash
fversion
```

and:

```bash
ls /workspace/data
```

can be used to verify the environment.

---

# FITS Files

## Viewing FITS Files on Windows

FITS files are stored in WSL, but they can also be accessed from Windows.

For example, the WSL filesystem can be accessed from Windows Explorer using:

```text
\\wsl$\
```

Navigate to the `data/` directory and open the FITS file with a FITS viewer installed on Windows.

The same FITS file can therefore be used by both:

```text
Windows FITS Viewer
        │
        ▼
      FITS file
        ▲
        │
        │
Docker / FTOOLS
```

No GUI application needs to be run inside the Docker container.

---

# VS Code

The repository can be opened directly from WSL using VS Code.

From the repository directory:

```bash
code .
```

VS Code can be used to edit the analysis code while the actual analysis tools run inside Docker.

If desired, the **Dev Containers** extension can also be used to open the development environment directly inside the Docker container.

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

# Make Commands

| Command      | Description                                                    |
| ------------ | -------------------------------------------------------------- |
| `make pull`  | Pull the pre-built Analysis Docker image                       |
| `make build` | Build the Analysis Docker image locally                        |
| `make test`  | Test the Analysis environment                                  |
| `make shell` | Start an interactive Analysis environment with `data/` mounted |

---

# Project Structure

```text
atmos_analysis/
├── Dockerfile
├── Makefile
├── README.md
├── requirements.txt
├── tests/
└── data/
```

The `data/` directory contains local analysis data and is not included in the Git repository.
