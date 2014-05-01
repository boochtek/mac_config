#!/bin/bash

## Install Homebrew.


source 'xcode.sh'


# Non-interactive, based on [https://github.com/Homebrew/homebrew/blob/go/install].
if [[ ! -d /usr/local/Cellar ]]; then
    sudo mkdir -p /usr/local
    sudo chmod g+rwx /usr/local
    sudo chgrp admin /usr/local

    sudo mkdir -p /Library/Caches/Homebrew
    sudo chmod g+rwx /Library/Caches/Homebrew

    cd /usr/local
    
    git init -q
    git remote add origin https://github.com/Homebrew/homebrew
    git fetch origin master:refs/remotes/origin/master -n
    git reset --hard origin/master
fi
