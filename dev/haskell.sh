#!/bin/bash

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" >&2 ; exit $RC' ERR

## Install GHC (Glasgow Haskell Compiler) and Stack via ASDF.
asdf plugin-add haskell
asdf install haskell 8.10.2


# VS Code plusins
# haskell-ide-engine - Tab completion plugin
# language-haskell - Syntax highlighting plugin
# ghcid - Interactive error reporting plugin
# hie-server - Jump to definition and tag handling plugin
# hlint - Linting and style-checking plugin
# ghcide - Interactive completion plugin
# ormolu-vscode - Code formatting plugin
