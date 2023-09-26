#!/bin/bash

## Configure trackpad.

# NOTE: You'll need to log out and back in for some of these (like tap-to-click) to work.

# Cache the sudo password.
echo "$(tput setaf 4)You may be prompted for your sudo password.$(tput sgr0)"
sudo -v

# Enable tap to click. (Don't have to press down on the trackpad -- just tap it.)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool TRUE
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool TRUE

# Enable "tap-and-a-half" to drag.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -int 1
defaults write com.apple.AppleMultitouchTrackpad Dragging -int 1

# Enable tap to click for the login screen. (May or may not work in Mavericks.)
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable 3-finger drag. (Moving with 3 fingers in any window "chrome" moves the window.)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool TRUE
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool TRUE

# Enable scroll-to-zoom with Ctrl (^) modifier key (and 2 fingers).
# defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool TRUE
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad HIDScrollZoomModifierMask -int 262144
defaults write com.apple.AppleMultitouchTrackpad HIDScrollZoomModifierMask -int 262144
sudo defaults write com.apple.universalaccess closeViewScrollWheelToggle -int 1
