#!/bin/bash

# NOTE: I'm moving away from using `asdf` in favor of `mise`.

# source "${BASH_SOURCE%/*}/../util/colors.sh"

## Install ASDF version manager, and ensure its dependencies are installed.
# brew install --quiet coreutils curl git
# brew install --quiet asdf

# chmod +x "$(brew --prefix asdf)/libexec/asdf.sh"

# To use `asdf`, you'll need to set $ASDF_DIR.
# If $ASDF_DIR is not set, set it for now, and tell the user to add it to their startup scripts.
# if [[ -z "$ASDF_DIR" ]]; then
#     echo "${BLUE}You'll need to add this to your \`~/.bash_profile\` or \`.zshrc\`:"
#     echo "${BLUE}    source \"$(brew --prefix asdf)/libexec/asdf.sh\"${RESET}"
#     source "$(brew --prefix asdf)/libexec/asdf.sh"
# fi
