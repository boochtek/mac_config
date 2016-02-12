#!/bin/bash

## Install Homebrew.


source 'xcode.sh'


# Install Homebrew itself, if it's not already installed.
# Non-interactive, based on [https://github.com/Homebrew/homebrew/blob/go/install].
# Or should we use `if test ! $(which brew); then` instead?
if [[ ! -d /usr/local/Cellar ]]; then
    # Create destination directory for Homebrew, and set permissions.
    sudo mkdir -p /usr/local
    sudo chgrp admin /usr/local
    sudo chmod g+rwx /usr/local
    sudo chgrp admin /usr/local/include
    sudo chmod g+rwx /usr/local/include

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
else
    brew update
fi


# Install Homebrew Cask, if it's not already installed.
if ! brew list | grep -q brew-cask ; then
    # Add the "tap" for Homebrew Cask to Homebrew.
    brew tap phinze/cask

    # Install Homebrew Cask.
    brew install brew-cask

    # Check for issues. Set permissions (prompting for sudo password) if necessary.
    brew cask doctor
fi


# Allow installing non-standard versions of packages. (For example, Sublime Text 3, Java 6, and older versions of GCC.)
brew tap homebrew/versions
brew tap caskroom/versions

# Allow installing fonts.
brew tap caskroom/fonts
brew tap niksy/pljoska
brew update
brew cask install font-microsoft-cleartype-family

# Enable Bash completion for Homebrew commands.
if [[ ! -f /usr/local/etc/bash_completion.d/brew_bash_completion.sh ]]; then
    mkdir -p /usr/local/etc/bash_completion.d
    ln -sf /usr/local/Library/Contributions/brew_bash_completion.sh /usr/local/etc/bash_completion.d/
fi

# Install libraries needed by other packages. (Per http://adarsh.io/bundler-failing-on-el-capitan/)
brew install openssl
brew link --force openssl # Probably only want this on El Capitan and later.

