#!/bin/bash

# MacOS comes with Zsh, but Homebrew usually has an updated version.
brew install --quiet zsh

# Additional completion definitions
brew install --quiet zsh-completions

# Show suggestions for full command lines, like Fish. Use cursor-right to accept.
brew install --quiet zsh-autosuggestions

# Automatically close brackets, quotes, etc.
brew install --quiet zsh-autopair

# Syntax highlighting as you type.
brew install --quiet zsh-syntax-highlighting

# Let's you know when you could use an alias.
brew install --quiet zsh-you-should-use
