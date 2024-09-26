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
    sudo chgrp admin $HOMEBREW_PREFIX
    sudo chmod g+rwx $HOMEBREW_PREFIX
    sudo chgrp admin $HOMEBREW_PREFIX/include
    sudo chmod g+rwx $HOMEBREW_PREFIX/include
    sudo chgrp admin $HOMEBREW_PREFIX/share
    sudo chmod g+rx $HOMEBREW_PREFIX/share

    # Create cache directory for Homebrew, and set permissions.
    sudo mkdir -p /Library/Caches/Homebrew
    sudo chmod g+rwx /Library/Caches/Homebrew

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

# Enable Bash completion for Homebrew commands.
if [[ ! -f $HOMEBREW_PREFIX/etc/bash_completion.d/brew_bash_completion.sh ]]; then
    mkdir -p $HOMEBREW_PREFIX/etc/bash_completion.d
    ln -sf $HOMEBREW_PREFIX/Library/Contributions/brew_bash_completion.sh $HOMEBREW_PREFIX/etc/bash_completion.d/
fi

# Install some libraries needed by other packages. (Per http://adarsh.io/bundler-failing-on-el-capitan/)
brew install --quiet openssl
brew link --force openssl # Probably only want this on El Capitan and later.
