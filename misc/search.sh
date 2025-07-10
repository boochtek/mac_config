#!/bin/bash

## Search tools.

# Ripgrep (`rg``) is the go-to, fastest modern search tool.
brew install --quiet ripgrep

# Ripgrep-all (`rga`) is an extension to search within PDFs, ZIPs, Office documents, etc.
brew install --quiet ripgrep-all

# TODO: Install poppler (PDF), pandoc (other text-like files), ffmpeg (audio/video files, metadata, subtitles, lyrics)



# Ack was the original modern search tool.
brew install --quiet ack

# The Silver Searcher (`ag`) is similar to Ack, newer and possibly better, but I still prefer Ack.
brew install --quiet the_silver_searcher

# fzf is a great fuzzy file-finder.
brew install --quiet fzf

# Generate `locate` database (`/var/db/locate.database`). This may take a while, but runs in the background.
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# Fdupes is a fast duplicate file finder.
brew install --quiet fdupes
