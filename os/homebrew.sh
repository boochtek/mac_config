#!/bin/bash

command-exists() {
    type -p "$1" >/dev/null
}

## Install Homebrew.

# Determine if we're on Apple Silicon or Intel. Homebrew gets installed different places for each.
if [[ $(arch) == 'i386' ]]; then
    export HOMEBREW_ARCH='x86_64'
    export HOMEBREW_PREFIX='/usr/local'
else
    export HOMEBREW_ARCH='arm64e'
    export HOMEBREW_PREFIX='/opt/homebrew'
fi
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_AUTO_UPDATE=1
export PATH=$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH

# Install Homebrew itself, if it's not already installed.
# Non-interactive, based on [https://github.com/Homebrew/homebrew/blob/go/install].
if ! command-exists brew ; then
    # Create destination directory for Homebrew, and set permissions.
    sudo mkdir -p $HOMEBREW_PREFIX $HOMEBREW_PREFIX/include $HOMEBREW_PREFIX/share
    sudo chown ${USER}:admin $HOMEBREW_PREFIX
    sudo chmod g+rwx $HOMEBREW_PREFIX
    sudo chown ${USER}:admin $HOMEBREW_PREFIX/include
    sudo chmod g+rwx $HOMEBREW_PREFIX/include
    sudo chown ${USER}:admin $HOMEBREW_PREFIX/share
    sudo chmod g+rwx $HOMEBREW_PREFIX/share

    # Create cache directory for Homebrew, and set permissions.
    sudo mkdir -p /Library/Caches/Homebrew
    sudo chmod g+rwx /Library/Caches/Homebrew

    # Tell git that it's OK for us to install to the directory.
    git config --global --add safe.directory $HOMEBREW_PREFIX

    # Download the latest version of Homebrew using git.
    (
        cd $HOMEBREW_PREFIX || exit
        git init -q
        git remote add origin https://github.com/Homebrew/brew
        git fetch origin master:refs/remotes/origin/master -n
        git reset --hard origin/master
    )

    # Check for configuration issues.
    brew doctor
else
    brew update
fi
