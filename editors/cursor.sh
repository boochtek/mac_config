#!/bin/bash

## Install and configure Cursor. NOTE: You'll need an API key.
brew install --quiet --cask --no-quarantine cursor

dockutil --add  '/Applications/Cursor.app' --replacing 'Cursor' --after 'Visual Studio Code' &> /dev/null


# Install and configure Windsurf.
brew install --quiet --cask --no-quarantine windsurf
dockutil --add  '/Applications/Windsurf.app' --replacing 'Windsurf' --after 'Cursor' &> /dev/null


# Install and configure Void. NOTE: You'll need an API key.
brew install --quiet --cask --no-quarantine void
dockutil --add  '/Applications/Void.app' --replacing 'Void' --after 'Windsurf' &> /dev/null
