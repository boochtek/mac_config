#!/bin/bash

## Install Neovim.
brew install --quiet neovim

## Install VimR, a GUI for Neovim.
brew install --quiet --cask --no-quarantine vimr

# Install (optional) prerequisites for LazyVim and Telescope.
brew install --quiet lazygit
brew install --quiet ripgrep # via [telescope](https://github.com/nvim-telescope/telescope.nvim)
brew install --quiet fd # via [telescope](https://github.com/nvim-telescope/telescope.nvim)
