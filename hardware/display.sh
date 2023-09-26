#!/bin/bash

# Cache the sudo password.
echo "$(tput setaf 4)You may be prompted for your sudo password.$(tput sgr0)"
sudo -v

# Enable zooming the display.
# System Preferences -> Accessibility -> Zoom -> Use scroll gesture with modifier keys to zoom
sudo defaults write com.apple.UniversalAccess closeViewScrollWheelToggle -bool TRUE

# Zoom the display when holding Control and scrolling up with 2 fingers or scroll wheel.
defaults write com.apple.UniversalAccess HIDScrollZoomModifierMask -int 262144

# When zooming the display, follow the keyboard focus.
# System Preferences -> Accessibility -> Zoom -> Zoom follows the keyboard focus
sudo defaults write com.apple.UniversalAccess closeViewZoomFollowsFocus -bool TRUE
