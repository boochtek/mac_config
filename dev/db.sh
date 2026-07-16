#!/bin/bash

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR

## Databases

# Usql is a modern "universal" DB CLI/REPL inspired by `psql`.
# It has drivers for PostgreSQL, MySQL, SQLite, SQL Server, Oracle, and CSV.
brew trust --formula xo/xo/usql
brew install --quiet xo/xo/usql
