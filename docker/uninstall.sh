#!/usr/bin/env bash

# Fail immediately if any errors occur
set -e

echo "Uninstalling all Autopilot docker images..."
docker rmi -f $(docker images --filter=reference="*/*/stride-autopilot:*" -q)

echo "Remove Autopilot user directory? (Y/N)"
read yesorno
if [ "$yesorno" = 'Y' ] || [ "$yesorno" = 'y' ]; then
    rm -rf ~/.autopilot/
fi

echo "Autopilot uninstalled successfully..."
