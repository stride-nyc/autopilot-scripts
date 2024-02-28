#!/usr/bin/env bash

# Fail immediately if any errors occur
set -e

# If you don't have python 3.11 and pipx installed, here's how you can install it:
# Install Brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# brew install python@3.11
# brew link python@3.11
# brew install pipx

VERSION="@${AUTOPILOT_VERSION:-main}"

echo "Installing Autopilot.."
pipx install -f "git+https://github.com/stride-nyc/stride-autopilot$VERSION"
echo ""

echo "Autopilot installed successfully. To start, run:"
echo ""
echo "autopilot init"
echo ""

echo "Autopilot commands can be listed with --help:"
autopilot --help
