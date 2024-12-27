#!/bin/bash

source "${BASH_SOURCE%/*}/../os/homebrew.sh"

# NOTE: Adding apps to the Dock should happen in the scripts where said apps are installed.

## Disable animations when opening an application from the Dock.
defaults write com.apple.dock launchanim -bool FALSE

## Automatically hide and show the Dock.
defaults write com.apple.dock autohide -bool TRUE

## Eliminate any delay before showing the Dock.
defaults write com.apple.Dock autohide-delay -float 0

# We use dockutil to add and remove icons in the Mac OS X dock.
## Install dockutil
brew install --quiet dockutil

## Remove rarely-used Dock items.
for dock_item in Siri Launchpad Contacts Notes Reminders Maps Messages FaceTime iBooks Podcasts TV News ; do
    dockutil --remove "$dock_item" &> /dev/null
done

## Add Activity Monitor to the Dock.
dockutil --find "Activity Monitor" &> /dev/null \
    || dockutil --add "/System/Applications/Utilities/Activity Monitor.app" --position end

## Show CPU graph in Activity Monitor icon in Dock.
defaults write com.apple.ActivityMonitor IconType -int 6

## Restart the Dock.
killall Dock
