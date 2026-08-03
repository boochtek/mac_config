#!/bin/bash

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" >&2 ; exit $RC' ERR

## Erlang
asdf plugin update erlang
asdf install erlang 23.1.5
# TODO: See if there are any old versions we want to get rid of. Maybe ask?

## Elixir (requires corresponding Erlang installation)
asdf plugin update elixir
asdf install elixir 1.11.2-otp-23
# TODO: See if there are any old versions we want to get rid of. Maybe ask?

# Install Expert LSP.
brew install --quiet expert
