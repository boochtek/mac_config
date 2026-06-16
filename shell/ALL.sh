#!/bin/bash

# Run from this script's own directory so each sub-script's relative paths resolve.
cd "$(dirname "$0")" || exit 1

./zsh.sh
./bash.sh
./terminal.sh
./iterm2.sh
./ghostty.sh
./zoxide.sh
./history.sh
./completion.sh
