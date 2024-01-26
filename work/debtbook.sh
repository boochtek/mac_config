#!/bin/bash

## Apps used specifically for DebtBook

# Variant of the unofficial Bash strict mode.
set -uo pipefail
IFS=$'\n\t'
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR
[[ -n "${DEBUG+unset}" ]] && set -x

# Slack

brew install --quiet --cask --no-quarantine slack

dockutil --add '/Applications/Slack.app' --replacing 'Slack' --position beginning &> /dev/null


# Docker

# Install Docker, and make sure it's current. (Using Docker Desktop for now.)
brew install --quiet --cask --no-quarantine docker
brew upgrade --cask docker
open -a Docker.app

echo "${BLUE}RECOMMENDATIONS for Docker Desktop Preferences:"
echo "* General: CHECK Start Docker Desktop when you log in"
echo "* Resources: increase Memory to 12 GB and swap to 4 GB"
echo "* Experimental Features: CHECK Use new Virtualization Framework and Enable VirtioFS accelerated directory sharing${RESET}"

# Docker Desktop includes Docker Compose, but we're installing this to avoid some problems we've encountered.
# Note that you can use either `docker-compose` or `docker compose` (but the former is about 1 second quicker).
brew install --quiet docker-compose
mkdir -p ~/.docker/cli-plugins
ln -sfn "$(brew --prefix docker-compose)/bin/docker-compose" ~/.docker/cli-plugins/docker-compose

# Note that docker-compose 2.x does not come with completion files. So we'll get the last 1.x version.
sudo curl -L https://raw.githubusercontent.com/docker/compose/v1.25.2/contrib/completion/zsh/_docker-compose -o "$(brew --prefix)/share/zsh/site-functions/_docker_compose"
sudo curl -L https://raw.githubusercontent.com/docker/compose/v1.25.2/contrib/completion/bash/docker-compose -o "$(brew --prefix)/etc/bash_completion.d/docker-compose"
