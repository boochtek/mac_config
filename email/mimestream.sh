#!/bin/bash

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" >&2 ; exit $RC' ERR

# Install Mimestream, which has extensive Gmail support.
brew install --quiet --cask mimestream

dockutil --add '/Applications/Mimestream.app' --replacing 'Mimestream' --after Mail
open -a Mimestream
