#!/usr/bin/env bash

# Fail immediately if any errors occur
set -e

# If you don't have Docker installed, here's how you can install it:
# Install Brew & Docker
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# brew install --cask docker
# open /Applications/Docker.app

DOCKER_CONTAINER=autopilot
DOCKER_HOST=ghcr.io
DOCKER_NAMESPACE=stride-nyc
DOCKER_IMAGE=stride-autopilot

VERSION="${AUTOPILOT_VERSION:-latest}"

echo "Logging into GitHub Packages container registry.."
echo $AUTOPILOT_GITHUB_TOKEN | docker login ghcr.io -u $AUTOPILOT_GITHUB_USER --password-stdin
echo ""

echo "Installing Autopilot.."
docker pull $DOCKER_HOST/$DOCKER_NAMESPACE/$DOCKER_IMAGE:$VERSION
echo ""

echo "Installing ~/.autopilot/run.sh.."
mkdir -p ~/.autopilot
cd ~/.autopilot
echo "#!/usr/bin/env bash" > run.sh
echo "" >> run.sh
echo "docker run -ti --name $DOCKER_CONTAINER -e AUTOPILOT_OPENAI_API_KEY=\$AUTOPILOT_OPEN_AI_API_KEY -v \"\$AUTOPILOT_PROJECT_PATH\":/codedir -w /codedir $DOCKER_HOST/$DOCKER_NAMESPACE/$DOCKER_IMAGE:$VERSION" >> run.sh
echo "" >> run.sh
chmod +x run.sh
echo ""
cd -

echo "Autopilot installed successfully. To start, run:"
echo ""
echo "AUTOPILOT_PROJECT_PATH=/absolute/path/to/my/project/code ~/.autopilot/run.sh"
echo ""
