#!/bin/bash

# NOTE: Adding apps to the Dock should happen in the scripts where said apps are installed.

## Disable animations when opening an application from the Dock.
defaults write com.apple.dock launchanim -bool FALSE

## Automatically hide and show the Dock.
defaults write com.apple.dock autohide -bool TRUE

# We use dockutil to add and remove icons in the Mac OS X dock.
## Install dockutil
# NOTE: Homebrew doesn't have dockutil 3.0 yet, as of 2022-05-28.
#brew install --quiet dockutil
# We're installing manually, until Homebrew gets 3.0.
wget https://github.com/kcrawford/dockutil/releases/download/3.0.2/dockutil-3.0.2.pkg
sudo installer -pkg dockutil-3.0.2.pkg -target /
rm -rf dockutil-3.0.2.pkg

## Remove rarely-used Dock items.
for dock_item in Siri Launchpad Contacts Notes Reminders Maps Messages FaceTime iBooks Podcasts TV ; do
    dockutil --remove "$dock_item" > /dev/null
done

## Add Activity Monitor to the Dock.
dockutil --find "Activity Monitor" > /dev/null \
    || dockutil --add "/System/Applications/Utilities/Activity Monitor.app" --position end

## Restart the Dock.
killall Dock
