#!/bin/bash

# NOTE: Adding apps to the Dock should happen in the scripts where said apps are installed.

## Disable animations when opening an application from the Dock.
defaults write com.apple.dock launchanim -bool FALSE

## Automatically hide and show the Dock.
defaults write com.apple.dock autohide -bool TRUE

# We use dockutil to add and remove icons in the Mac OS X dock.
## Install dockutil
brew install --quiet dockutil

## Remove rarely-used Dock items.
for dock_item in Siri Launchpad Contacts Notes Reminders Maps Messages FaceTime iBooks Podcasts TV ; do
    dockutil --remove "$dock_item" 1>/dev/null
done

## Add Activity Monitor to the Dock.
dockutil --find "Activity Monitor" 1>/dev/null \
    || dockutil --add "/System/Applications/Utilities/Activity Monitor.app" --position end

## Restart the Dock.
killall Dock
