#!/bin/bash

## Configure system menu bar the way we want it.

# TODO: Make menu bar not translucent.

# Clock - display day of week, 12-hour time (but no AM/PM) digital clock with a non-flashing separator.
defaults write com.apple.menuextra.clock IsAnalog -bool false
defaults write com.apple.menuextra.clock DateFormat "EEE h:mm"

# Battery - show percentage charged.
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# TODO: Remove from menu bar - User (is that a default? any others?)

# TODO: Disable Notification Center. Try http://www.defaults-write.com/disable-notification-center-in-mac-os-x-mountain-lion/#.U32cGpRdXag

# TODO: In Keyboard preferences, Keyboard pane, CHECK “Show Keyboard & Character Viewers in menu bar”.
