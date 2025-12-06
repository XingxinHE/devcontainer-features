#!/bin/bash
set -e

PACKAGES=${PACKAGES:-""}

echo "Activating feature 'robotpkg'"

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

echo "Robotpkg feature installation complete."
