#!/usr/bin/env bash

# Fail immediately if any errors occur
set -e

echo "Uninstalling all Conductor docker images..."
docker rmi -f $(docker images --filter=reference="*/*/stride-autopilot:*" -q)

echo "Remove Conductor user directory? (Y/N)"
read yesorno
if [ "$yesorno" = 'Y' ] || [ "$yesorno" = 'y' ]; then
    rm -rf ~/.conductor/
fi

echo "Conductor uninstalled successfully..."
