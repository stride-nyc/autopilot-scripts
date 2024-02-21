# Autopilot Scripts

## Prerequisites

Autopilot requires Python 3.11.x to be installed.

```bash
-> % python --version
Python 3.11.x
```

On MacOS, you can install this version of Python using homebrew.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install python@3.11
brew link python@3.11
```

You should [authenticate to GitHub using a personal access token][github-access-token]. Your token should at least have Read Repo capabilities.

[github-access-token]: https://docs.github.com/en/enterprise-server@3.9/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

## Install

To setup the autopilot CLI, run the below bash script.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/autopilot-scripts/main/install.sh)"
```

You can install a specific version by setting `AUTOPILOT_VERSION` before running the script (ex. `export AUTOPILOT_VERSION=v3.0.0`).

## Running

The Autopilot virtual environment must be activated in order to start using the autopilot command line tool.

```bash
source ~/.autopilot/.venv/bin/activate
autopilot --help
```

You can deactivate the virtual environment when you're done working with the tool.

```bash
deactivate
```

##  Uninstall

To uninstall the autopilot CLI from the client machine, run the below bash script.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/autopilot-scripts/main/uninstall.sh)"
```
