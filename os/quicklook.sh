#!/bin/bash

## Configure QuickLook to handle more file types.

## CREDITS:
##  Most of these were recommended by https://github.com/sindresorhus/quick-look-plugins
##  Text selection feature recommended by http://lifehacker.com/5874280/copy-text-from-quick-look-previews-with-a-terminal-hack


# Preview Markdown files.
brew install --no-quarantine --cask qlmarkdown

# Preview plain text files without a file extension (README, CHANGELOG, etc.).
brew install --no-quarantine --cask qlstephen

# Preview source code files for various programming languages, with syntax highlighting.
brew install --no-quarantine --cask qlcolorcode

# Preview JSON files.
brew install --no-quarantine --cask quicklook-json

# Preview CSV files.
brew install --no-quarantine --cask quicklook-csv

# Preview diffs.
brew install --no-quarantine --cask qlprettypatch

# Preview archives (ZIP, tar, gzip, bzip2, ARJ, LZH, ISO, etc.).
brew install --no-quarantine betterzip

# Preview SSL/X509 certificate files (CRT, PEM, DER, etc.). (No longer available via Homebrew.)
#brew install --no-quarantine cert-quicklook

# Preview WEBP images.
brew install --no-quarantine webpquicklook

# Preview most video formats.
brew install --no-quarantine qlvideo

# Preview AVIF images.
brew install --no-quarantine avifquicklook

# Reload QuickLook daemon, so new plugins will work.
qlmanage -r

# Enable text selection in QuickLook views.
defaults write com.apple.finder QLEnableTextSelection -bool TRUE
killall Finder
