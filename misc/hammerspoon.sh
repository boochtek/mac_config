#!/bin/bash

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR

# Install Hammerspoon
brew install --quiet --cask hammerspoon
open -a Hammerspoon
echo "TODO: enable Hammerspoon in System Settings > Privacy & Security > Accessibility"
