# Autopilot Scripts

These scripts will install or uninstall [Autopilot] CLI as a python package.

[Autopilot]: https://github.com/stride-nyc/stride-autopilot

## Python Pacakge Approach

This install approach uses Python 3.11 and Pipx to install a autopilot in Python package. The autopilot CLI is available at paths from your terminal. The commands run against project that is at the current working directory of the terminal session. It requires a GitHub User and Token for the Stride-NYC organization and an Open AI API Key.

### Prerequisites

#### Python and Pipx

On MacOS, you can install Python 3.11 and Pipx using homebrew.

```bash
# = Install Homebrew =
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# = Install Python =
brew install python@3.11
# python3.11 needs to be linked on your PATH, this sets that up
brew link python@3.11

# = Install Pipx =
brew install pipx
# pipx install location needs to be on your PATH, this sets that up
pipx ensurepath
```

You can check that pipx is pointing to the correct python install directory by comparing `PIPX_DEFAULT_PYTHON` from pipx environment to your python3.11 path.

```bash
which python3.11
pipx environment
```

If you are using a Python version manager, such as asdf, this output may not match up. You may need to install pipx through another method, like the [asdf-pipx] plugin.

[asdf-pipx]: https://github.com/yozachar/asdf-pipx

### Authentication

Installing by Python Package needs [an authenticated connection to GitHub using https][github-https]. Your user should be part of the Stride-NYC GitHub organization.

To authenticate to GitHub with https, you can either:
- [authenticate using the GitHub CLI][github-cli]. This will prompt you for 2FA login via GitHub.com.
- OR [authenticate to GitHub using a personal access token][github-access-token]. Your token should at least have Read Repo capabilities ([view/edit token permissions], [create new token]). When prompted by git for use and password, use your GitHub username and the GitHub personal access token as password.

[github-https]: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-authentication-to-github#https
[github-cli]: https://cli.github.com/
[github-access-token]: https://docs.github.com/en/enterprise-server@3.9/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
[view/edit token permissions]: https://github.com/settings/tokens
[create new token]: https://github.com/settings/tokens/new

### Install

To setup the autopilot CLI, run the below bash script.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/autopilot-scripts/${AUTOPILOT_SCRIPTS_VERSION:-main}/python/install.sh)"
```

You can install a specific version by setting `AUTOPILOT_VERSION` before running the script (ex. `export AUTOPILOT_VERSION=v0.3.2`).

### Running

The Autopilot virtual environment must be activated in order to start using the autopilot command line tool.

```bash
# inside the docker container with your project files mounted at /codedir/
autopilot init   # create user and project configuration
autopilot --help # see a list of autopilot commands
autopilot main   # run autopilot interactively
```

You can deactivate the virtual environment when you're done working with the tool.

```bash
deactivate
```

##  Uninstall

To uninstall the autopilot CLI from the client machine, run the below bash script.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/autopilot-scripts/${AUTOPILOT_SCRIPTS_VERSION:-main}/python/uninstall.sh)"
```
