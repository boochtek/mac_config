#!/bin/bash

## Install and configure web browsers.

source 'homebrew.sh'
source 'dockutil.sh'


# Install Chrome browser.
brew install --quiet --cask --no-quarantine google-chrome
dockutil --add  '/Applications/Google Chrome.app' --replacing 'Google Chrome' --before 'Safari'

# Chrome TODO (manual):
#   * Make sure 1Password works properly. FIXME: Need cask apps deployed into /Applications instead of locally.
#   * Install AdBlocker Ultimate extension.
#   * Install OneTab (recommended by Mikhail).

## Install Chromium browser.
brew install --quiet --cask --no-quarantine chromium
dockutil --add  '/Applications/Chromium.app' --replacing 'Chromium' --after 'Google Chrome'


## Install Vivaldi browser.
brew install --quiet --cask --no-quarantine vivaldi
dockutil --add  '/Applications/Vivaldi.app' --replacing 'Vivaldi' --after 'Chromium'
# MANUAL CONFIG:
#   Preferences / Tabs / Tab Features / Tab Cycling
#       SELECT Cycle in tab order

## Install Arc browser.
brew install --quiet --cask --no-quarantine arc
dockutil --add  '/Applications/Arc.app' --replacing 'Arc' --after 'Vivaldi'
# WARNING: The first time Arc starts up, it's got some fancy graphics and sound playing.


# Install Microsoft Edge.
# NOTE: You'll be prompted for your password.
brew install --quiet --cask --no-quarantine microsoft-edge
dockutil --add  '/Applications/Microsoft Edge.app' --replacing 'Microsoft Edge' --after 'Vivaldi'


# Install Firefox browser.
brew install --quiet --cask --no-quarantine firefox
dockutil --add  '/Applications/Firefox.app' --replacing 'Firefox' --after 'Safari'

# Firefox TODO (manual):
#   * View / Toolbars / CHECK Bookmarks Toolbar
#   * Addons
#   * Make sure 1Password works properly.

# Install Firefox browser Developer Edition.
brew install --quiet --cask --no-quarantine firefox-developer-edition
dockutil --add  '/Applications/Firefox Developer Edition.app' --replacing 'Firefox Developer Edition' --after 'Firefox'


# We'll use [Finicky](https://github.com/johnste/finicky) to use different browsers for different sites and web apps.
# Alternatives: [Choosy](https://www.choosyosx.com/), Browser Fairy, Browserosaurus, OpenIn, Browser ChooserX
brew install --quiet --cask --no-quarantine finicky
# WARNING: You'll be prompted to change your default browser to Finicky. Click **Use "Finicky"**.
open -a Finicky

# TODO: Make sure Finicky starts at login.
#   Manual: System Settings / General / Login Items / + `/Applications/Finicky.app`
