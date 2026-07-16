#!/bin/bash

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR

# TODO: Install via ASDF.
# TODO: Make sure Shard is included.

## Crystal is a Ruby-like lanugage, compiled, with type inference.
brew install crystal-lang --with-llvm

