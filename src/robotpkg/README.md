# Robotpkg Feature

This feature sets up the robotpkg repository and installs robotics software packages on Ubuntu systems.

## Overview

Robotpkg is a package management system for robotics software maintained by the Gepetto team at LAAS-CNRS. It provides easy access to pre-built robotics libraries and tools, including:
- Pinocchio (rigid body dynamics)
- HPP (motion planning)
- SOT (stack of tasks)
- And many more robotics packages

## Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `packages` | string | `robotpkg-pinocchio` | Comma-separated list of robotpkg packages to install |

## Requirements

- Ubuntu 20.04, 22.04, or 24.04
- Network access to http://robotpkg.openrobots.org
- Sufficient disk space for selected packages

## Features

- Automatically configures the robotpkg apt repository
- Installs the Gepetto team's robotics software collection
- Supports multiple package installation via comma-separated list
- Non-interactive installation for CI/CD pipelines
- Proper cleanup to minimize container image size

## Usage Example

Install the default package (Pinocchio):

```json
{
  "features": {
    "ghcr.io/your-org/robotpkg": {}
  }
}
```

Install specific packages:

```json
{
  "features": {
    "ghcr.io/your-org/robotpkg": {
      "packages": "robotpkg-pinocchio,robotpkg-hpp-pinocchio"
    }
  }
}
```

Or set up the repository only (empty package list):

```json
{
  "features": {
    "ghcr.io/your-org/robotpkg": {
      "packages": ""
    }
  }
}
```

## Available Packages

Some popular robotpkg packages include:

- `robotpkg-pinocchio` - Rigid body dynamics algorithms
- `robotpkg-hpp-pinocchio` - Motion planning with Pinocchio
- `robotpkg-sot-core` - Stack of Tasks framework
- `robotpkg-qt4-python3` - Python bindings for Qt4
- `robotpkg-omniorb` - CORBA middleware

For a complete list, visit: http://robotpkg.openrobots.org

## Verification

After installation, verify packages are installed:

```bash
# Check installed robotpkg packages
dpkg -l | grep robotpkg

# Test Pinocchio installation (if installed)
python3 -c "import pinocchio; print(pinocchio.__version__)"
```

## Links

- [Robotpkg Installation Guide](http://robotpkg.openrobots.org/debian.html)
- [Pinocchio Documentation](https://gepettoweb.laas.fr/doc/stack-of-tasks/pinocchio/devel/doxygen-html/)