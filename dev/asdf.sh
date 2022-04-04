#!/bin/bash

## Install ASDF version manager, and ensure its dependencies are installed.
brew install --quiet coreutils curl git
brew install --quiet asdf

# NOTE: To use `asdf`, you'll need to `source $(brew --prefix asdf)/asdf.sh` in your `~/.bash_profile` or `.zshrc` file.
