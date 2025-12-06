#!/bin/bash
set -e

PACKAGES=${PACKAGES:-""}

if [ -z "${PACKAGES}" ]; then
    echo "No packages specified, and no upgrade required. Skip installation..."
    exit 0
fi

rm -rf /var/lib/apt/lists/*

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

echo "Activating feature 'realsense'"
echo "Selected packages: $PACKAGES"

export DEBIAN_FRONTEND=noninteractive

# Install prerequisites
apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    gnupg \
    lsb-release \
    apt-transport-https

# 1. Register the server's public key
mkdir -p /etc/apt/keyrings
curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | tee /etc/apt/keyrings/librealsense.pgp > /dev/null

# 2. Add the server to the list of repositories
echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" | \
tee /etc/apt/sources.list.d/librealsense.list > /dev/null

apt-get update

# 3. Construct package list
TO_INSTALL=""

# Check for "utils"
if [[ "$PACKAGES" == *"utils"* ]]; then
    TO_INSTALL="$TO_INSTALL librealsense2-utils"
fi

# Check for "dev"
if [[ "$PACKAGES" == *"dev"* ]]; then
    TO_INSTALL="$TO_INSTALL librealsense2-dev"
fi

# Check for "dbg"
if [[ "$PACKAGES" == *"dbg"* ]]; then
    TO_INSTALL="$TO_INSTALL librealsense2-dbg"
fi

if [ -z "$TO_INSTALL" ]; then
    echo "No valid packages selected. Installing nothing."
else
    echo "Installing packages: $TO_INSTALL"
    apt-get install -y --no-install-recommends $TO_INSTALL
fi

# Clean up
rm -rf /var/lib/apt/lists/*

export DEBIAN_FRONTEND=dialog

echo "Realsense feature installation complete."
