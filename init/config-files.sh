# This file is sourced to prepare to set up the Mac.

# This should work in Bash or Zsh (maybe others), but tell shellcheck it's Bash:
# shellcheck shell=bash


# If `CONFIG_FILES_URL` is not set, abort.
if [[ -z "$CONFIG_FILES_URL" ]]; then
    echo 'CONFIG_FILES_URL is not set. Aborting.'
    exit 1
fi

# Set `CONFIG_FILES_BRANCH` to `main` if it's not set.
CONFIG_FILES_BRANCH="${CONFIG_FILES_BRANCH:-main}"

# Install config files.
if [[ ! -d "$HOME/.config" ]]; then
    git clone "$CONFIG_FILES_URL" --branch="$CONFIG_FILES_BRANCH" "$HOME/.config"
    cd "$HOME/.config"
    ./install.sh
    cd -
fi
