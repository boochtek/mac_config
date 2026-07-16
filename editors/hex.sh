#!/bin/bash

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR

## Install [Helix Editor](https://helix-editor.com/).
# Helix is terminal-only, run via the `hx` command.
# Helix is inspired by NeoVim, with a lot of nice built-in features.
brew install --quiet helix
