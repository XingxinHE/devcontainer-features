#!/bin/bash
set -e

source dev-container-features-test-lib

# Only utils should be installed
check "realsense-viewer exists" which realsense-viewer
check "headers do NOT exist" test ! -d /usr/include/librealsense2

reportResults