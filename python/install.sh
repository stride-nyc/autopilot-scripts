#!/usr/bin/env bash

# Fail immediately if any errors occur
set -e

# If you don't have python 3.11 and pipx installed, here's how you can install it:
# Install Brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# brew install python@3.11
# brew link python@3.11
# brew install pipx

VERSION="@${CONDUCTOR_VERSION:-main}"

echo "Installing Conductor.."
pipx install -f "git+https://github.com/stride-nyc/stride-autopilot$VERSION"
echo ""

echo "Conductor pipx installed successfully."
echo ""

echo "Command conductor now accessible from any path in the console. The files at your current path will be used as a basis for the active project."
echo ""

echo "Start with 'conductor init' to set up your user and project config."
echo ""
echo "conductor init"
echo ""

echo "Conductor commands can be listed with conductor --help."
conductor --help
