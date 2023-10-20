#!/bin/bash

source "${BASH_SOURCE%/*}/../os/homebrew.sh"

# Show Debug menu in App Store app.
defaults write com.apple.appstore 'ShowDebugMenu' -bool TRUE

## Install MAS (Mac App Store CLI) utility and apps that have been installed through App Store.
## NOTE: You may be prompted (via GUI) to sign into the Mac App Store.

# Install MAS.
brew install mas

# Install Magnet window manager. Start it at login and now.
# if [[ ! -e '/Applications/Magnet.app' ]]; then
#     mas list | grep -q 'Magnet' || mas lucky 'Magnet'
#     osascript -e 'tell application "System Events" to make login item with properties {path:"/Applications/Magnet.app", hidden:true}' >/dev/null
#     open -gj -a 'Magnet'
# fi

# Install Collective clipboard manager. Start it at login and now.
if [[ ! -e '/Applications/Collective.app' ]]; then
    mas list | grep -q 'Collective' || mas lucky 'Collective'
    osascript -e 'tell application "System Events" to make login item with properties {path:"/Applications/Collective.app", hidden:true}' >/dev/null
    open -gj -a 'Collective'
fi

# Install Bear note-taking app. Start it at login and now.
if [[ ! -e '/Applications/Bear.app' ]]; then
    mas list | grep -q 'Bear' || mas lucky 'Bear'
    osascript -e 'tell application "System Events" to make login item with properties {path:"/Applications/Bear.app", hidden:false}' >/dev/null
    open -gj -a 'Bear'
fi

# Install Firetask task-tracking app. Start it at login and now.
if [[ ! -e '/Applications/Firetask.app' ]]; then
    mas list | grep -q 'Firetask' || mas lucky 'Firetask'
    osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Firetask.app", hidden:true}' >/dev/null
    open -gj -a 'Firetask'
fi

# TODO: More apps from the App Store.
# TODO: What else should we auto-start?
# TODO: Add items to Dock, as appropriate. (Make sure we've installed dockutils before this gets run.)

dockutil --remove  'App Store'
