# Conductor Scripts

These scripts will install or uninstall [Conductor] CLI as a python package.

[Conductor]: https://github.com/stride-nyc/conductor

## Python Pacakge Approach

This install approach uses Python 3.11 and Pipx to install a Conductor in Python package. The Conductor CLI is available at paths from your terminal. The commands run against project that is at the current working directory of the terminal session. It requires a GitHub User and Token for the Stride-NYC organization and an Open AI API Key.

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

### Environment Variables

The install script expects the following environment variables to be set for your shell (you may have been provided environment variables by a member of the team).

```bash
export CONDUCTOR_GITHUB_USER="bobby@example.com"
export CONDUCTOR_GITHUB_TOKEN=gh_token
export CONDUCTOR_OPENAI_API_KEY=oai_token
export CONDUCTOR_VERSION=0.4.1
export CONDUCTOR_SCRIPTS_VERSION=main
```

### Authentication

Installing Conductor by Python Package needs [an authenticated connection to GitHub using https][github-https]. The GitHub User should be part of the Stride-NYC GitHub organization.

To authenticate to GitHub with https, you can either:
- [Authenticate using the GitHub CLI.][github-cli]. This will prompt you in a browser window for 2FA login via GitHub.com.
- OR [Authenticate using a GitHub personal access token.][github-access-token] Your token should at least have Repo capabilities ([view/edit token permissions], [create new token]). When prompted for git user and password, use your GitHub Username and the GitHub personal access token as password.

You may be provided a GitHub User and Token by the team.

[github-https]: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-authentication-to-github#https
[github-cli]: https://cli.github.com/
[github-access-token]: https://docs.github.com/en/enterprise-server@3.9/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
[view/edit token permissions]: https://github.com/settings/tokens
[create new token]: https://github.com/settings/tokens/new

### Install

To setup the Conductor CLI, run the below bash script.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/conductor-scripts/${CONDUCTOR_SCRIPTS_VERSION:-main}/python/install.sh)"
```

### Running

Conductor CLI tool will be available at all paths when it is installed through pipx.

```bash
cd path/to/my-cool-project/
conductor init   # create user and project configuration
conductor --help # see a list of Conductor commands
conductor -i     # run Conductor interactively
```

##  Uninstall

To uninstall the Conductor CLI from the client machine, run the below bash script.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/conductor-scripts/${CONDUCTOR_SCRIPTS_VERSION:-main}/python/uninstall.sh)"
```
