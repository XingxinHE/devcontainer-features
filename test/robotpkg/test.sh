#!/bin/bash
set -e

source dev-container-features-test-lib

# Test: Check if repo list exists
check "robotpkg.list exists" test -f /etc/apt/sources.list.d/robotpkg.list

reportResults