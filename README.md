# Conductor Scripts

This repo provides two approaches to quickly install and uninstall the [Conductor] CLI on any machine.

[Conductor]: https://github.com/stride-nyc/conductor

## Install Approaches

### Docker

This install approach uses Docker to download a docker image containing Conductor CLI and its dependencies. It runs Conductor in a container and mounts a project folder with code from your laptop. It requires a GitHub User and Token for the Stride-NYC organization and an Open AI API Key.

See [Docker README][docker/README.md].

### Python Package

This install approach uses Python 3.11 and Pipx to install Conductor in Python package. The Conductor CLI is available at paths from your terminal. The commands run against project that is at the current working directory of the terminal session. It requires a GitHub User and Token for the Stride-NYC organization and an Open AI API Key.

See [Python README][python/README.md].

## Common Prerequisites

You may have been provided these as part of a demo setup. Otherwise, reach out on Stride Slack in the `#it-support-request` channel.

## GitHub Username

The **GitHub Username** should be a part of the [Stride-NYC organization].

[Stride-NYC organization]: https://github.com/orgs/stride-nyc/people

## GitHub Persoal Access Token

In order to securely access GitHub, you can [authenticate to GitHub using a personal access token][github-access-token].

You can [view/edit token permissions][github-edit-token] or [create new token][github-new-token] on GitHub developer settings.

Minimum permissions:

- Python Package: `repo` (read)
- Docker: `read:packages`
- General development (recommended):  `repo` (all), `read/write:packages`, `workflow`.

[github-access-token]: https://docs.github.com/en/enterprise-server@3.9/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
[github-edit-token]: https://github.com/settings/tokens
[github-new-token]: https://github.com/settings/tokens/new

## Open AI API Key

If you have an Open AI account, you can [manage your APIs key on this screen][openai-apikey].

[openai-apikey]: https://platform.openai.com/api-keys
