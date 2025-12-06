#!/bin/bash
set -e

source dev-container-features-test-lib

# Test: Check if robotpkg-pinocchio is installed
check "robotpkg-pinocchio installed" dpkg -l robotpkg-pinocchio

reportResults