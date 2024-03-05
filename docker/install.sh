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

# trim v0.4.0 to 0.4.0
# git tag starts with v - docker tag does not.
git_tag_pattern="^v[0-9]*\.[0-9]*\.[0-9]*$"
if [[ $VERSION =~ $git_tag_pattern ]]; then
    VERSION=${VERSION:1}
fi

echo "Logging into GitHub Packages container registry.."
echo $AUTOPILOT_GITHUB_TOKEN | docker login ghcr.io -u $AUTOPILOT_GITHUB_USER --password-stdin
echo ""

echo "Installing Autopilot Docker Image ${VERSION}.."
docker pull $DOCKER_HOST/$DOCKER_NAMESPACE/$DOCKER_IMAGE:$VERSION
echo ""

echo "Installing ~/.autopilot/run.sh to run docker image.."
mkdir -p ~/.autopilot
cd ~/.autopilot
echo "#!/usr/bin/env bash" > run.sh
echo "" >> run.sh
echo 'PROJECT_PATH=${AUTOPILOT_PROJECT_PATH:-$(pwd)}' >> run.sh
echo "docker run -ti --rm --name $DOCKER_CONTAINER -e AUTOPILOT_OPENAI_API_KEY=\$AUTOPILOT_OPENAI_API_KEY -v "$HOME/.autopilot/":/root/.autopilot -v \"\$PROJECT_PATH\":/codedir -w /codedir $DOCKER_HOST/$DOCKER_NAMESPACE/$DOCKER_IMAGE:$VERSION" >> run.sh
echo "" >> run.sh
chmod +x run.sh
echo ""
cd -

echo "Autopilot docker and run script installed successfully."
echo ""

echo "Run the docker image run to make the autopilot command available. The files at your current path will be available in the container."
echo ""
echo "cd path/to/my/project/code && ~/.autopilot/run.sh"
echo ""

echo "Start with 'autopilot init' to set up your user and project config."
echo ""

echo "Autopilot commands can be listed with autopilot --help."
echo ""
