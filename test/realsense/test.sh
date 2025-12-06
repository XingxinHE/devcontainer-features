#!/bin/bash
set -e

source dev-container-features-test-lib

# Test 1: Check if realsense-viewer is available (from utils)
check "realsense-viewer exists" which realsense-viewer

# Test 2: Check if headers exist (from dev)
check "librealsense2 headers exist" test -d /usr/include/librealsense2

# Test 3: Check if dbg symbols are installed (from dbg)
# This location might vary, but usually it's in /usr/lib/debug
check "librealsense2 dbg symbols exist" dpkg -l librealsense2-dbg

reportResults