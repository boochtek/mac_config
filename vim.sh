#!/bin/bash

## Install and configure Vim.


## NOTE: Most Vim configuration will be done via personal config files.


## Installation

# Install from Homebrew, so we get the latest version.
brew install vim

# Install ctags, to generate indexes to allow us to easily locate things by name.
brew install ctags

# Install and update Vundle plugins. (Assumes .vimrc loads Vumdle and lists plugins.)
vim -c 'VundleInstall' -c 'VundleUpdate' -c 'qa!'
