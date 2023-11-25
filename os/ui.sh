#!/bin/bash

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
mkdir "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
killall SystemUIServer

## Save screen captures as PNG format instead of TIFF.
defaults write com.apple.screencapture type -string 'PNG'

## Restart SystemUIServer, so changes to screen capture settings will take effect.
killall SystemUIServer
