#!/bin/bash

## Install and configure web browsers.

source 'homebrew.sh'
source 'dockutil.sh'


# Install Chrome browser.
brew cask install google-chrome

# Add an icon to the Dock.
dockutil --add  '~/Applications/Google Chrome.app' --replacing 'Google Chrome' --after Safari

# Chrome TODO (manual):
#   * Make sure 1Password works properly. FIXME: Need cask apps deployed into /Applications instead of locally.
#   * Install AdBlocker Ultimate extension

# Install Firefox browser.
brew cask install firefox

# Add an icon to the Dock.
dockutil --add  '~/Applications/Firefox.app' --replacing Firefox --after 'Google Chrome'

# Firefox TODO (manual):
#   * View / Toolbars / CHECK Bookmarks Toolbar
#   * Addons


# Install Chromium browser.
brew cask install chromium
