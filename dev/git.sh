#!/bin/bash

# Xcode CLI Tools will have already installed git, but we want to stay more up-to-date.
# This was especially important for the CVE-2014-9390 vulnerability.
brew install --quiet git
brew link git

# Git-Crypt allows encrypting some of the files in your repository. See https://www.agwa.name/projects/git-crypt/.
brew install --quiet git-crypt

# Git-LFS allows storing larger files. See https://git-lfs.com/.
# GitHub limits files to 100 MB. You can add on LFS for $5/month for 50 GB, with a file size limit of 2 GB.
brew install --quiet git-lfs

# LazyGit provides a TUI that makes some git operations easier.
brew install --quiet lazygit

# Suggested by Olivier Lacan https://twitter.com/olivierlacan/status/646741176922587141
git config --global credential.helper osxkeychain

# Make diffs more human-readable.
brew install --quiet diff-so-fancy
