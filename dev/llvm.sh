#!/bin/bash

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" >&2 ; exit $RC' ERR

# NOTE: I'd prefer to install via `mise`, to track versions, but it's not available.

brew install --quiet llvm
brew install --quiet lld