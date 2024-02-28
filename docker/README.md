# Autopilot Scripts

These scripts will install or uninstall [Autopilot] CLI as a Docker image with a wrapper script to run it inside a container.

[Autopilot]: https://github.com/stride-nyc/stride-autopilot

## Docker Approach

This install approach uses Docker to download a docker image containing autopilot CLI and its dependencies. It runs autopilot in a container and mounts a project folder with code from your laptop. It requires a GitHub User and Token for the Stride-NYC organization and an Open AI API Key.

### Prerequisites

#### Docker

This method for running autopilot requires Docker. On Mac, Docker can be installed using Homebrew.

```bash
# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Docker Desktop
brew install --cask docker

# Open Docker Desktop, accept agreements and get started.
open /Applications/Docker.app
```

#### Environment Variables

The install script expects the following environment variables to be set for your shell (you may have been provided these by a member of the team).

```bash
export AUTOPILOT_GITHUB_USER="bobby@example.com"
export AUTOPILOT_GITHUB_TOKEN=gh_token
export AUTOPILOT_OPEN_AI_API_KEY=oai_token
export AUTOPILOT_VERSION=0.3.2
```

### Install

To setup the autopilot CLI docker image, run the below bash script.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/autopilot-scripts/main/docker/install.sh)"
```

### Running

The Autopilot install script provides a wrapper to start an autopilot docker container. Your project files will be mounted in the container to work on. Once you've attached to the docker container, you can run autopilot commands.

```bash
AUTOPILOT_PROJECT_PATH=/absolute/path/to/my/project/code ~/autopilot/run.sh
# inside the docker container with your project files mounted at /codedir/
autopilot init   # create user and project configuration
autopilot --help # see a list of autopilot commands
autopilot main   # run autopilot interactively
```

### Uninstall

To uninstall all autopilot CLI docker images from the client machine, run the below bash script.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/autopilot-scripts/main/docker/uninstall.sh)"
```
