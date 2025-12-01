# Zivid SDK Feature

This feature installs the Zivid SDK and related tools for 3D machine vision cameras on Ubuntu systems.

## Overview

Zivid is a manufacturer of industrial 3D color cameras for machine vision. This feature installs:
- Zivid SDK (`zivid`)
- Zivid Studio GUI application (`zivid-studio`)
- Zivid command-line tools (`zivid-tools`)
- Zivid GenICam implementation (`zivid-genicam`)

## Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `ubuntuVersion` | string | `24` | Ubuntu version code (`20`, `22`, or `24`) |
| `zividVersion` | string | `2.17.1+7516d437-1` | Zivid SDK version to install |

## Requirements

- Ubuntu 20.04, 22.04, or 24.04
- For NVIDIA GPU support, appropriate NVIDIA drivers and OpenCL libraries
- Network access to download Zivid packages from https://downloads.zivid.com

## Features

- Automatically configures OpenCL for NVIDIA GPUs
- Creates required system groups (`video`, `render`) for camera access
- Includes Python development headers for Python API usage
- Cleans up installation artifacts to minimize image size

## Usage Example

```json
{
  "features": {
    "ghcr.io/your-org/zivid": {
      "ubuntuVersion": "24",
      "zividVersion": "2.17.1+7516d437-1"
    }
  }
}
```

## Links

- [Zivid SDK Documentation](https://support.zivid.com/en/latest/getting-started/software-installation.html)
- [Docker Installation Guide](https://support.zivid.com/en/latest/api-reference/docker/install-zivid-in-docker.html)
- [OpenCL Configuration](https://support.zivid.com/en/latest/support/opencl-issues.html)