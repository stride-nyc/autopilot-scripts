#!/usr/bin/env bash

# Fail immediately if any errors occur
set -e

echo "Uninstalling Conductor..."
pipx uninstall stride-autopilot
pip3.11 cache purge

echo "Remove Conductor user directory? (Y/N)"
read yesorno
if [ "$yesorno" = 'Y' ] || [ "$yesorno" = 'y' ]; then
    rm -rf ~/.conductor/
fi

echo "Conductor uninstalled successfully..."
