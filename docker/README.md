# Conductor Scripts

These scripts will install or uninstall [Conductor] CLI as a Docker image with a wrapper script to run it inside a container.

[Conductor]: https://github.com/stride-nyc/stride-autopilot

## Docker Approach

This install approach uses Docker to download a docker image containing Conductor CLI and its dependencies. It runs Conductor in a container and mounts a project folder with code from your laptop. It requires a GitHub User and Token for the Stride-NYC organization and an Open AI API Key.

### Prerequisites

#### Docker

This method for running Conductor requires Docker. On Mac, Docker can be installed using Homebrew.

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
export CONDUCTOR_GITHUB_USER="bobby@example.com"
export CONDUCTOR_GITHUB_TOKEN=gh_token
export CONDUCTOR_OPENAI_API_KEY=oai_token
export CONDUCTOR_VERSION=0.3.2
```

### Install

To setup the Conductor CLI docker image, run the below bash script.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/autopilot-scripts/main/docker/install.sh)"
```

### Running

The Conductor install script provides a wrapper to start an Conductor docker container. Your project files will be mounted in the container to work on. Once you've attached to the docker container, you can run Conductor commands.

```bash
cd path/to/my-cool-project/
~/.conductor/run.sh # run a new container with the present directory as project path
ls                 # docker container mounts your project files at /codedir/
conductor init     # create user and project configuration
conductor --help   # see a list of conductor commands
conductor -i       # run conductor interactively
```

### Uninstall

To uninstall all Conductor CLI docker images from the client machine, run the below bash script.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/autopilot-scripts/main/docker/uninstall.sh)"
```
