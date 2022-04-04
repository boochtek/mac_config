#!/bin/bash

brew install --no-quarantine --cask iterm2

open -a /Applications/iTerm.app

dockutil --add  '/Applications/iTerm.app' --replacing 'iTerm' --after 'Photos'
