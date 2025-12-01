# Xingxin's Devcontainer Features:

This is my current tech stacks.

## Features

This repository contains a _collection_ of Features.

| Name | URL | Description |
| ---  | --- | ---         |
| zivid | https://support.zivid.com/en/latest/getting-started/software-installation.html | The SDK and software for Zivid 3D color cameras. |


### zivid

Zivid camera SDK and software.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:noble",
    "features": {
        "zivid": {
            "ubuntuVersion": "24",
            "zividVersion": "2.16.0+46cdaba6-1"
        }
    }
}
```

```bash
ZividListCameras
```
