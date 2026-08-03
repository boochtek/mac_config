#!/bin/bash

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" >&2 ; exit $RC' ERR

# TODO: Install via ASDF.

## Io
# Install the required XQuartz first. NOTE: Requires password interactively.
brew install --quiet --cask xquartz
# Install the language itself.
brew install io
