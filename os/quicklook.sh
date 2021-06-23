#!/bin/bash

## Configure QuickLook to handle more file types.

## CREDITS:
##  Most of these were recommended by https://github.com/sindresorhus/quick-look-plugins
##  Text selection feature recommended by http://lifehacker.com/5874280/copy-text-from-quick-look-previews-with-a-terminal-hack


source 'homebrew.sh'


# Preview Markdown files.
brew cask install qlmarkdown
xattr -dr com.apple.quarantine ~/Library/QuickLook/QLMarkdown.qlgenerator

# Preview plain text files without a file extension (README, CHANGELOG, etc.).
brew cask install qlstephen
xattr -dr com.apple.quarantine ~/Library/QuickLook/QLStephen.qlgenerator

# Preview source code files for various programming languages, with syntax highlighting.
brew cask install qlcolorcode
xattr -dr com.apple.quarantine ~/Library/QuickLook/QLColorCode.qlgenerator

# Preview JSON files.
brew cask install quicklook-json
xattr -dr com.apple.quarantine ~/Library/QuickLook/QuickLookJSON.qlgenerator

# Preview CSV files.
brew cask install quicklook-csv
xattr -dr com.apple.quarantine ~/Library/QuickLook/QuickLookCSV.qlgenerator

# Preview diffs.
brew cask install qlprettypatch
xattr -dr com.apple.quarantine ~/Library/QuickLook/QLPrettyPatch.qlgenerator

# Preview archives (ZIP, tar, gzip, bzip2, ARJ, LZH, ISO, etc.).
brew cask install betterzipql

# Preview SSL/X509 certificate files (CRT, PEM, DER, etc.).
brew cask install cert-quicklook

# Reload QuickLook daemon, so new plugins will work.
qlmanage -r

# Enable text selection in QuickLook views.
defaults write com.apple.finder QLEnableTextSelection -bool TRUE
killall Finder
