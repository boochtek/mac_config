# This file is sourced to prepare to set up the Mac.

# This should work in Bash or Zsh (maybe others), but tell shellcheck it's Bash:
# shellcheck shell=bash

if source ./ENV.sh ; then
    source ./init/shared-functions.sh
    source ./init/command-line-tools.sh
    source ./init/homebrew.sh
    source ./init/config-files.sh
fi
