#!/bin/bash

## Configure Finder the way we want it.

## Many of these settings come from https://github.com/mathiasbynens/dotfiles/blob/master/.osx.
## Note that some of these settings also affect File Open and Save dialogs.


## TODO:
##  * Add items to Sidebar Favorites (com.apple.sidebarlists):
##    * Personal
##    * Work
##    * Projects
##    * Utilities
##  * Remove items from Sidebar Favorites (com.apple.sidebarlists):
##    * All My Files
##    * iCloud Drive
##    * Airdrop



# Don't bother with the "desktop" behind all our windows. From http://lifehacker.com/hide-and-show-desktop-icons-on-os-x-with-an-automator-s-5704241
defaults write com.apple.finder CreateDesktop false

# Allow quitting Finder.
defaults write com.apple.finder QuitMenuItem -bool true

# When opening a new window, start in the home directory.
defaults write com.apple.finder NewWindowTargetPath "file://$HOME"

# Show file extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files.
defaults write com.apple.finder AppleShowAllFiles -bool true

# Don't warn about changing a file extension.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable window animations and Get Info animations in Finder.
defaults write com.apple.finder DisableAllAnimations -bool true

# Show Path Bar.
defaults write com.apple.finder ShowPathbar -bool true

# Show Status Bar.
defaults write com.apple.finder ShowStatusBar -bool true

# Show Tab Bar.
defaults write com.apple.finder ShowTabView -bool true

# Display full path in window titles.
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Don't clutter network volumes with .DS_Store files.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Warn before emptying the Trash.
defaults write com.apple.finder WarnOnEmptyTrash -bool true

# Empty Trash securely by default.
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Use list view in all Finder windows by default. Other view modes: 'icnv', 'clmv', 'Flwv'.
defaults write com.apple.finder FXPreferredViewStyle -string 'Nlsv'

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set sidebar icon size to medium.
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Don't show any special icons on desktop.
defaults write ShowExternalHardDrivesOnDesktop -bool false
defaults write ShowHardDrivesOnDesktop -bool false
defaults write ShowRemovableMediaOnDesktop -bool false
defaults write ShowMountedServersOnDesktop -bool false

# Enable spring loading for directories, with no delay.
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Enable Sharing & Permissions section in Info panels for files and directories.
defaults write com.apple.finder FXInfoPanesExpanded -dict Privileges -bool false

# Show Sidebar, but remove the Tags section.
defaults write com.apple.finder ShowSidebar -bool true
defaults write com.apple.finder ShowRecentTags -bool false


# Restart Finder so settings will take effect.
killall Finder
