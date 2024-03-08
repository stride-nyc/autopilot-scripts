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

VERSION="${CONDUCTOR_VERSION:-latest}"

# trim v0.4.0 to 0.4.0
# git tag starts with v - docker tag does not.
git_tag_pattern="^v[0-9]*\.[0-9]*\.[0-9]*$"
if [[ $VERSION =~ $git_tag_pattern ]]; then
    VERSION=${VERSION:1}
fi

echo "Logging into GitHub Packages container registry.."
echo $CONDUCTOR_GITHUB_TOKEN | docker login ghcr.io -u $CONDUCTOR_GITHUB_USER --password-stdin
echo ""

echo "Installing Conductor Docker Image ${VERSION}.."
docker pull $DOCKER_HOST/$DOCKER_NAMESPACE/$DOCKER_IMAGE:$VERSION
echo ""

echo "Installing ~/.conductor/run.sh to run docker image.."
mkdir -p ~/.conductor
cd ~/.conductor
echo "#!/usr/bin/env bash" > run.sh
echo "" >> run.sh
echo 'PROJECT_PATH=${CONDUCTOR_PROJECT_PATH:-$(pwd)}' >> run.sh
echo "docker run -ti --rm --name $DOCKER_CONTAINER -e CONDUCTOR_OPENAI_API_KEY=\$CONDUCTOR_OPENAI_API_KEY -v "$HOME/.conductor/":/root/.conductor -v \"\$PROJECT_PATH\":/codedir -w /codedir $DOCKER_HOST/$DOCKER_NAMESPACE/$DOCKER_IMAGE:$VERSION" >> run.sh
echo "" >> run.sh
chmod +x run.sh
echo ""
cd -

echo "Conductor docker and run script installed successfully."
echo ""

echo "Run the docker image run to make the Conductor command available. The files at your current path will be available in the container."
echo ""
echo "cd path/to/my/project/code && ~/.conductor/run.sh"
echo ""

echo "Start with 'conductor init' to set up your user and project config."
echo ""

echo "Conductor commands can be listed with conductor --help."
echo ""
