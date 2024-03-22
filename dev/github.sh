#!/bin/bash

# Variant of the unofficial Bash strict mode.
set -uo pipefail
IFS=$'\n\t'
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR
[[ -n "${DEBUG+unset}" ]] && set -x


# GitHub command line tool.
brew install --quiet gh

# GitHub Copilot extension for gh. Use `gh copilot suggest` or `gh copilot explain` to use it.
gh extension install github/gh-copilot
