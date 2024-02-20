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

You should [authenticate with GitHub using a personal access token][github-access-token].

[github-access-token]: https://docs.github.com/en/enterprise-server@3.9/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

## Install

How to setup a client to use the autopilot CLI.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/autopilot-scripts/main/install.sh)"
```

##  Uninstall

How to uninstall the autopilot CLI from client machine.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/autopilot-scripts/main/un`install.sh)"
```
