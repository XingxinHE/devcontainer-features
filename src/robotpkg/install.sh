#!/bin/bash
set -e

PACKAGES=${PACKAGES:-""}

echo "Activating feature 'robotpkg'"

rm -rf /var/lib/apt/lists/*

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

# Install prerequisites
apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    gnupg \
    lsb-release

# 1. Add robotpkg key
mkdir -p /etc/apt/keyrings
curl -fsSL http://robotpkg.openrobots.org/packages/debian/robotpkg.asc | tee /etc/apt/keyrings/robotpkg.asc > /dev/null

# 2. Add robotpkg repository
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/robotpkg.asc] http://robotpkg.openrobots.org/packages/debian/pub $(lsb_release -cs) robotpkg" | tee /etc/apt/sources.list.d/robotpkg.list > /dev/null

apt-get update

if [ -z "${PACKAGES}" ]; then
    echo "No packages specified, and no upgrade required. Skip installation..."
    exit 0
fi

# 3. Install packages if provided
if [ -n "$PACKAGES" ]; then
    # Replace commas with spaces for apt-get
    INSTALL_LIST=$(echo "$PACKAGES" | tr ',' ' ')
    echo "Installing packages: $INSTALL_LIST"
    apt-get install -y --no-install-recommends $INSTALL_LIST
else
    echo "No specific packages requested. Repository setup only."
fi

# Clean up
rm -rf /var/lib/apt/lists/*
export DEBIAN_FRONTEND=dialog

echo "Robotpkg feature installation complete."
