#!/bin/bash

## Install Homebrew.


source 'xcode.sh'


# Install Homebrew itself, if it's not already installed.
# Non-interactive, based on [https://github.com/Homebrew/homebrew/blob/go/install].
if [[ ! -d /usr/local/Cellar ]]; then
    # Create destination directory for Homebrew, and set permissions.
    sudo mkdir -p /usr/local
    sudo chmod g+rwx /usr/local
    sudo chgrp admin /usr/local

    # Create cache directory for Homebrew, and set permissions.
    sudo mkdir -p /Library/Caches/Homebrew
    sudo chmod g+rwx /Library/Caches/Homebrew

    # Download the latest version of Homebrew using git.
    cd /usr/local
    git init -q
    git remote add origin https://github.com/Homebrew/homebrew
    git fetch origin master:refs/remotes/origin/master -n
    git reset --hard origin/master

    # Check for configuration issues.
    brew doctor
fi


# Install Homebrew Cask, if it's not already installed.
if ! brew list | grep -q brew-cask ; then
    # Add the "tap" for Homebrew Cask to Homebrew.
    brew tap phinze/cask

    # Install Homebrew
    brew install brew-cask

    # Check for issues. Set permissions (prompting for sudo password) if necessary.
    brew cask doctor
fi
