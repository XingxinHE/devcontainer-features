# Xingxin's Devcontainer Features:

This is my current tech stacks.

## Features

This repository contains a _collection_ of DevContainer Features for robotics and computer vision development.

| Name | Description |
| ---  | ---         |
| [zivid](./src/zivid/README.md) | The SDK and software for Zivid 3D color cameras. |
| [realsense](./src/realsense/README.md) | Intel RealSense SDK 2.0 for depth cameras. |
| [robotpkg](./src/robotpkg/README.md) | Robotpkg repository with robotics software packages. |

## Quick Start

Add any of these features to your `devcontainer.json`:

### Zivid 3D Camera

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:noble",
    "features": {
        "zivid": {
            "ubuntuVersion": "24",
            "zividVersion": "2.17.1+7516d437-1"
        }
    }
}
```

### Intel RealSense

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:noble",
    "features": {
        "realsense": {
            "packages": "utils,dev,dbg"
        }
    }
}
```

### Robotpkg

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:noble",
    "features": {
        "robotpkg": {
            "packages": "robotpkg-pinocchio"
        }
    }
}
```

## Repository Structure

- `src/<feature>/` - Feature source code and installation scripts
- `test/<feature>/` - Automated tests for each feature
- `.github/workflows/` - CI/CD for testing and releasing features
