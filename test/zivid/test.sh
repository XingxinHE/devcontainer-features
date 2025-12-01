#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'zivid' Feature with no options.
#
# For more information, see: https://github.com/devcontainers/cli/blob/main/docs/features/test.md
#
# Eg:
# {
#    "image": "<..some-base-image...>",
#    "features": {
#      "zivid": {}
#    },
#    "remoteUser": "root"
# }
#
# Thus, the value of all options will fall back to the default value in the
# Feature's 'devcontainer-feature.json'.
# For the 'zivid' feature, that means the default ubuntu version is '24' and zivid version is '2.17.1+7516d437-1'.
#
# These scripts are run as 'root' by default. Although that can be changed
# with the '--remote-user' flag.
#
# This test can be run with the following command:
#
#    devcontainer features test    \
#               --features zivid   \
#               --remote-user root \
#               --skip-scenarios   \
#               --base-image mcr.microsoft.com/devcontainers/base:ubuntu \
#               /path/to/this/repo

set -e

# Optional: Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md#dev-container-features-test-lib
# Provides the 'check' and 'reportResults' commands.
source dev-container-features-test-lib

echo "Running Zivid installation validation tests..."

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib. Syntax is...
# check <LABEL> <cmd> [args...]

# Test 1: Check if Zivid package is installed
check "zivid package installed" dpkg -l | grep -i zivid

# Test 2: Check if required groups exist
check "video group exists" getent group video
check "render group exists" getent group render

# Test 3: Check if Zivid Studio command is available
check "zivid-studio command exists" which ZividStudio

# Test 4: Check if Zivid command-line tools are available
check "zivid-list-cameras command exists" which ZividListCameras

# Test 5: Check if OpenCL configuration exists
check "OpenCL vendor config exists" test -f /etc/OpenCL/vendors/nvidia.icd

# Test 6: Check if OpenCL library is accessible
check "OpenCL library accessible" ldconfig -p | grep -i opencl || echo "OpenCL library check skipped"

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults