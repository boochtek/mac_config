#!/bin/bash

## Configure QuickLook to handle more file types.

## CREDITS:
##  Most of these were recommended by https://github.com/sindresorhus/quick-look-plugins
##  Text selection feature recommended by http://lifehacker.com/5874280/copy-text-from-quick-look-previews-with-a-terminal-hack


# Preview Markdown files.
# TODO: Had to download and install 1.3.1 manually, until `brew cask` includes that version.
# TODO: Also had to apply patch from https://github.com/toland/qlmarkdown/pull/32.
brew cask install qlmarkdown

# Preview plain text files without a file extension (README, CHANGELOG, etc.).
brew cask install qlstephen

# Preview source code files for various programming languages, with syntax highlighting.
brew cask install qlcolorcode

# Preview JSON files.
brew cask install quicklook-json

# Preview CSV files.
brew cask install quicklook-csv

# Preview diffs.
brew cask install qlprettypatch

# Preview archives (ZIP, tar, gzip, bzip2, ARJ, LZH, ISO, etc.).
brew cask install betterzipql

# Preview SSL/X509 certificate files (CRT, PEM, DER, etc.).
brew cask install cert-quicklook

# Reload QuickLook daemon, so new plugins will work.
qlmanage -r
