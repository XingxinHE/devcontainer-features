# Intel RealSense SDK Feature

This feature installs the Intel RealSense SDK 2.0 for depth cameras on Ubuntu systems.

## Overview

Intel RealSense cameras provide depth perception and tracking capabilities for robotics and computer vision applications. This feature installs:
- RealSense SDK utilities (`librealsense2-utils`)
- RealSense development libraries (`librealsense2-dev`)
- RealSense debug symbols (`librealsense2-dbg`)

## Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `packages` | string | `utils,dev,dbg` | Comma-separated list of packages. Options: `utils`, `dev`, `dbg` |

## Package Options

- `utils`: Command-line tools and utilities (e.g., `realsense-viewer`)
- `dev`: Development headers and libraries
- `dbg`: Debug symbols for development
- ~~`dkms`: Since it is related to kernel, it might not be portable in devcontainer.~~

## Requirements

- **Ubuntu 20.04, 22.04, or 24.04** (Debian is not supported by Intel's repository)
- Network access to download packages from Intel's repository
- Compatible Intel RealSense camera hardware

## Platform Support

This feature only supports **Ubuntu** distributions. Debian is not supported because Intel's RealSense repository does not provide Debian packages.

## Features

- Configures Intel's official apt repository
- Selective package installation based on your needs
- Non-interactive installation suitable for automated builds
- Automatic cleanup to minimize image size

## Usage Example

```json
{
  "features": {
    "ghcr.io/your-org/realsense": {
      "packages": "utils,dev,dbg"
    }
  }
}
```

Or install only specific packages:

```json
{
  "features": {
    "ghcr.io/your-org/realsense": {
      "packages": "utils"
    }
  }
}
```

## Verification

After installation, verify with:

```bash
# List connected RealSense cameras
realsense-viewer &

# Or use command-line tools
rs-enumerate-devices
```

## Links

- [Intel RealSense SDK Documentation](https://github.com/IntelRealSense/librealsense)
- [Official Debian Package Installation](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md)