#!/bin/bash

# Variant of the unofficial Bash strict mode.
set -Euo pipefail
IFS=$'\n\t'
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" >&2 ; exit $RC' ERR
[[ -n "${DEBUG+unset}" ]] && set -x

# Install [Jujutsu](https://jj-vcs.github.io/).
brew install --quiet jj

# Configure Jujutsu user, if not already set.
if [[ -z "$(jj config get user.name)" ]]; then
    jj config set --user user.name "$USER_FULL_NAME"
    jj config set --user user.email "$USER_EMAIL_ADDRESS"
fi

# TODO: Move this to config files.
# Enable command completion.
source <(jj util completion "$(basename "$SHELL")")
