#!/bin/bash

# Variant of the unofficial Bash strict mode.
set -uo pipefail
IFS=$'\n\t'
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR
[[ -n "${DEBUG+unset}" ]] && set -x


# GitHub command line tool.
brew install --quiet gh

# NOTE: This will hang until you enter the one-time code in GitHub.
# Authenticate with GitHub, if we have not already.
if ! gh auth status > /dev/null 2>&1 ; then
    gh config set prompt disabled
    open https://github.com/login/device &
    gh auth login
fi

# NOTE: You have to be authenticated to install extensions.
# GitHub Copilot extension for gh. Use `gh copilot suggest` or `gh copilot explain` to use it.
gh extension install github/gh-copilot 2> /dev/null
