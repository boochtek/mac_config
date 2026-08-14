# This file is sourced to prepare to set up the Mac.

# This should work in Bash or Zsh (maybe others), but tell shellcheck it's Bash:
# shellcheck shell=bash

# If `CONFIG_FILES_URL` is not set, abort.
if [[ -z "$CONFIG_FILES_URL" ]]; then
    echo 'CONFIG_FILES_URL is not set. Aborting.'
    return 1
fi

# Set `CONFIG_FILES_BRANCH` to `main` if it's not set.
CONFIG_FILES_BRANCH="${CONFIG_FILES_BRANCH:-main}"

# Install config files.
#
# This file is sourced, so the `cd` must stay in a subshell: a bare `cd` would
# move the caller for the rest of the setup.
if [[ ! -d "$HOME/.config" ]]; then
    if ! git clone "$CONFIG_FILES_URL" --branch="$CONFIG_FILES_BRANCH" "$HOME/.config"; then
        echo "Failed to clone config files from $CONFIG_FILES_URL. Aborting." >&2
        return 1
    fi
    (cd "$HOME/.config" && ./install.sh)
fi
