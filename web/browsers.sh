#!/bin/bash

## Install and configure web browsers.

source 'homebrew.sh'
source 'dockutil.sh'


# Install Chrome browser.
brew install --no-quarantine --cask google-chrome

# Add an icon to the Dock.
dockutil --add  '/Applications/Google Chrome.app' --replacing 'Google Chrome' --before 'Safari'

# Chrome TODO (manual):
#   * Make sure 1Password works properly. FIXME: Need cask apps deployed into /Applications instead of locally.
#   * Install AdBlocker Ultimate extension

# Install Firefox browser.
brew install --no-quarantine --cask firefox

# Add an icon to the Dock.
dockutil --add  '/Applications/Firefox.app' --replacing 'Firefox' --after 'Safari'

# Firefox TODO (manual):
#   * View / Toolbars / CHECK Bookmarks Toolbar
#   * Addons


# Install Chromium browser.
brew install --no-quarantine --cask chromium
