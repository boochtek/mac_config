#!/bin/bash

# Cache the sudo password.
echo "$(tput setaf 4)You may be prompted for your sudo password.$(tput sgr0)"
sudo -v

## Reduce transparency effects.
# System Preferences -> Accessibility -> Display -> Reduce transparency.
sudo defaults write com.apple.universalaccess reduceTransparency -bool TRUE

## Disable animations when opening and closing windows.
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool FALSE

## Always show scroll bars.
defaults write NSGlobalDomain AppleShowScrollBars Always

## Expand save dialogs by default.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool TRUE

## Save dialogs should not default to iCloud.
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool FALSE

## Expand print dialogs by default.
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool TRUE

## Save screen captures in `Pictures/Screenshots` instead of `Desktop`.
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
killall SystemUIServer

## Save screen captures as PNG format instead of TIFF.
defaults write com.apple.screencapture type -string 'PNG'

## Remove shadow from screenshots.
defaults write com.apple.screencapture disable-shadow -bool TRUE

## Restart SystemUIServer, so changes to screen capture settings will take effect.
killall SystemUIServer

## Don't display "Application Downloaded from Internet".
defaults write com.apple.LaunchServices LSQuarantine -bool FALSE

# Don't rearrange Spaces.
defaults write com.apple.dock mru-spaces -bool FALSE