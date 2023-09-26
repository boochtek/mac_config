#!/bin/bash

brew install --quiet --cask --no-quarantine iterm2

open -a /Applications/iTerm.app

dockutil --add  '/Applications/iTerm.app' --replacing 'iTerm' --after 'Photos'
