#!/bin/bash

source "${BASH_SOURCE%/*}/../os/dock.sh"

# Install iTerm2.
brew install --quiet --cask --no-quarantine iterm2

# Add iTerm2 to the Dock. Allow time for it to get added before opening the app.
dockutil --add  '/Applications/iTerm.app' --replacing 'iTerm' --after 'Photos' &> /dev/null
sleep 2

# Open iTerm2.
open -a /Applications/iTerm.app
