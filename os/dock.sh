#!/bin/bash

# NOTE: Adding apps to the Dock should happen in the scripts where said apps are installed.

## Disable animations when opening an application from the Dock.
defaults write com.apple.dock launchanim -bool FALSE

## Automatically hide and show the Dock.
defaults write com.apple.dock autohide -bool TRUE

# We use dockutil to add and remove icons in the Mac OS X dock.
## Install dockutil
# TODO: Once Homebrew gets dockutil 3.0, we can go back to using it.
#brew install --quiet dockutil
wget https://github.com/kcrawford/dockutil/releases/download/3.0.2/dockutil-3.0.2.pkg
sudo installer -pkg dockutil-3.0.2.pkg -target /
rm dockutil-3.0.2.pkg


## Remove rarely-used Dock items.
for dock_item in Siri Launchpad Contacts Notes Reminders Maps Messages FaceTime iBooks Podcasts TV ; do
    dockutil --remove "$dock_item" 1>/dev/null
done

## Add Activity Monitor to the Dock.
dockutil --find "Activity Monitor" 1>/dev/null \
    || dockutil --add "/System/Applications/Utilities/Activity Monitor.app" --position end

## Restart the Dock.
killall Dock
