#!/bin/bash

## Microsoft Office

# NOTE: There's a `microsoft-office` cask, but I don't want to install all the apps.

# Dependencies / nice-to-have.
brew install --quiet --cask --no-quarantine microsoft-auto-update
brew install --quiet niksy/pljoska/font-microsoft-cleartype-family

# Install individual Office apps.
brew install --quiet --cask --no-quarantine microsoft-word
brew install --quiet --cask --no-quarantine microsoft-excel
# brew install --quiet --cask --no-quarantine microsoft-powerpoint
# brew install --quiet --cask --no-quarantine microsoft-outlook
# brew install --quiet --cask --no-quarantine microsoft-remote-desktop
# brew install --quiet --cask --no-quarantine onedrive

# Add to Dock.
dockutil --add  '/Applications/Microsoft Word.app' --replacing 'Microsoft Word' --after 'Obsidian' &> /dev/null
dockutil --add  '/Applications/Microsoft Excel.app' --replacing 'Microsoft Excel' --after 'Microsoft Word' &> /dev/null
# dockutil --add  '/Applications/Microsoft PowerPoint.app' --replacing 'Microsoft PowerPoint' --after 'Microsoft Excel' &> /dev/null
# dockutil --add  '/Applications/Microsoft Outlook.app' --replacing 'Microsoft Outlook' --after 'Mail' &> /dev/null
# dockutil --add  '/Applications/Microsoft Remote Desktop.app' --replacing 'Microsoft Remote Desktop' --after 'iTerm' &> /dev/null
# dockutil --add  '/Applications/OneDrive.app' --replacing 'OneDrive' --after 'Microsoft Remote Desktop' &> /dev/null
