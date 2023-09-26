#!/bin/bash

## Configure QuickLook to handle more file types.

## CREDITS:
##  Most of these were recommended by https://github.com/sindresorhus/quick-look-plugins
##  Text selection feature recommended by http://lifehacker.com/5874280/copy-text-from-quick-look-previews-with-a-terminal-hack

# Cache the sudo password.
echo "$(tput setaf 4)You may be prompted for your sudo password.$(tput sgr0)"
sudo -v

# Preview Markdown files.
brew install --quiet --cask --no-quarantine qlmarkdown

# Preview plain text files without a file extension (README, CHANGELOG, etc.).
brew install --quiet --cask --no-quarantine qlstephen

# Preview source code files for various programming languages, with syntax highlighting.
brew install --quiet --cask --no-quarantine qlcolorcode

# Preview JSON files.
brew install --quiet --cask --no-quarantine quicklook-json

# Preview CSV files.
brew install --quiet --cask --no-quarantine quicklook-csv

# Preview diffs.
brew install --quiet --cask --no-quarantine qlprettypatch

# Preview archives (ZIP, tar, gzip, bzip2, ARJ, LZH, ISO, etc.).
brew install --quiet --cask --no-quarantine betterzip

# Preview SSL/X509 certificate files (CRT, PEM, DER, etc.). (No longer available via Homebrew.)
#brew install --quiet --cask --no-quarantine cert-quicklook

# Preview WEBP images.
brew install --quiet --cask --no-quarantine webpquicklook

# Preview most video formats.
brew install --quiet --cask --no-quarantine qlvideo

# Preview AVIF images.
brew install --quiet --cask --no-quarantine avifquicklook

# Reload QuickLook daemon, so new plugins will work.
qlmanage -r

# Enable text selection in QuickLook views.
defaults write com.apple.finder QLEnableTextSelection -bool TRUE
killall Finder
