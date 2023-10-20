#!/bin/bash

set -uo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR


# [Zed](https://zed.dev) is a new text editor by the authors of Atom and Tree-sitter.
brew install --quiet --cask --no-quarantine zed

dockutil --add  '/Applications/Zed.app' --replacing 'Zed' --after 'Visual Studio Code' &> /dev/null
