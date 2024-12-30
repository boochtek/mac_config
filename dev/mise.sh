#!/bin/bash

# NOTE: I'm moving away from using `asdf` in favor of `mise`.

source "${BASH_SOURCE%/*}/../os/homebrew.sh"
source "${BASH_SOURCE%/*}/../util/colors.sh"

## Install Mise version manager.
brew install --quiet mise

# If Mise has not been activated, activate it now, and tell user how to add it to startup scripts.
if [[ -z "$MISE_SHELL" ]]; then
    eval "$(mise activate)"
    echo "${BLUE}You'll need to add this to your \`~/.bash_profile\` or \`.zshrc\`:"
    echo "${BLUE}    eval \"$(mise activate)\"${RESET}"
fi
