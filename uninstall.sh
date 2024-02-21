#!/usr/bin/env bash

# Fail immediately if any errors occur
set -e

echo "Uninstalling Autopilot..."
pip3.11 uninstall -y stride-autopilot
pip3.11 cache purge

echo "Removing virtual environment..."
rm -rf ~/.autopilot/.venv

echo "Remove Autopilot user directory?"
read yesorno
if [ "$yesorno" = 'Y' ] || [ "$yesorno" = 'y' ]; then
    rm -rf ~/.autopilot/
fi

echo "Autopilot uninstalled successfully..."
