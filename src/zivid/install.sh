#!/bin/bash
set -e

echo "Activating feature 'zivid'"

# Set defaults if not provided
UBUNTU_VERSION=${UBUNTUVERSION:-24}
ZIVID_VERSION=${ZIVIDVERSION:-2.17.1+7516d437-1}

echo "The provided Ubuntu version is: $UBUNTU_VERSION"
echo "The provided Zivid SDK version is: $ZIVID_VERSION"

echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

echo "The effective dev container containerUser is '$_CONTAINER_USER'"
echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"

# --- Install Zivid SDK ---
echo "Installing Zivid SDK..."

# Update package list and install prerequisites
apt-get update && apt-get install --assume-yes \
    wget \
    ocl-icd-libopencl1

# Configure OpenCL for NVIDIA
mkdir -p /etc/OpenCL/vendors && \
echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

# Create temporary directory for installation
mkdir -p /tmp/zivid_install && cd /tmp/zivid_install

echo "Using Zivid SDK for Ubuntu version code: u${UBUNTU_VERSION}"

# Download Zivid packages
wget -q \
    https://downloads.zivid.com/sdk/releases/${ZIVID_VERSION}/u${UBUNTU_VERSION}/amd64/zivid_${ZIVID_VERSION}_amd64.deb \
    https://downloads.zivid.com/sdk/releases/${ZIVID_VERSION}/u${UBUNTU_VERSION}/amd64/zivid-studio_${ZIVID_VERSION}_amd64.deb \
    https://downloads.zivid.com/sdk/releases/${ZIVID_VERSION}/u${UBUNTU_VERSION}/amd64/zivid-tools_${ZIVID_VERSION}_amd64.deb \
    https://downloads.zivid.com/sdk/releases/${ZIVID_VERSION}/u${UBUNTUVERSION}/amd64/zivid-genicam_${ZIVID_VERSION}_amd64.deb

# Install packages
apt-get update && apt-get install -y ./*.deb && \
apt-get install -y python3-dev && \
rm -rf /var/lib/apt/lists/*

# Return to original directory and clean up
cd / && rm -rf /tmp/zivid_install

# Create video and render groups if they don't exist
if ! getent group video >/dev/null; then
    groupadd --gid 44 video
fi
if ! getent group render >/dev/null; then
    groupadd --gid 992 render
fi

echo "Zivid SDK installation completed successfully!"