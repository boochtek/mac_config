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

# Preview source code files with syntax highlighting.
# TODO: Customize. See https://github.com/sbarex/SourceCodeSyntaxHighlight#install-with-homebrew-cask.
brew install --quiet --cask --no-quarantine syntax-highlight

# Preview plain text files without a file extension (README, CHANGELOG, etc.).
brew install --quiet --cask --no-quarantine qlstephen
# Have QLStephen handle plist files.
plutil -insert CFBundleDocumentTypes.0.LSItemContentTypes.0 -string 'com.apple.property-list' "$HOME/Library/QuickLook/QLStephen.qlgenerator/Contents/Info.plist"
# Don't let QLColorCode handle plist files.
cp "$HOME/Library/QuickLook/QLColorCode.qlgenerator/Contents/Info.plist" "$HOME/Library/QuickLook/QLColorCode.qlgenerator/Contents/Info.plist.BAK"
index=$(plutil -convert json -r "$HOME/Library/QuickLook/QLColorCode.qlgenerator/Contents/Info.plist" -o - | jq '.CFBundleDocumentTypes[0].LSItemContentTypes | index("com.apple.property-list")')
plutil -remove "CFBundleDocumentTypes.0.LSItemContentTypes.$index" "$HOME/Library/QuickLook/QLColorCode.qlgenerator/Contents/Info.plist"

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
