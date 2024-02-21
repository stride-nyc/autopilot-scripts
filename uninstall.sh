#!/usr/bin/env bash

# Fail immediately if any errors occur
set -e

echo "Uninstalling Autopilot..."
pip3.11 uninstall -y stride-autopilot

echo "Removing virtual environment..."
pip3.11 cache purge
if [ -z "$(command -v deactivate)" ]; then
    deactivate
if

echo "Removing Autopilot user directory..."
rm -rf ~/.autopilot

echo "Autopilot uninstalled successfully..."
