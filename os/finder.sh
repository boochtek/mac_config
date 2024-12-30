#!/bin/bash

source "${BASH_SOURCE%/*}/../os/homebrew.sh"

## Configure Finder the way we want it.

## Many of these settings come from https://github.com/mathiasbynens/dotfiles/blob/master/.osx.
## Note that some of these settings also affect File Open and Save dialogs.

# Allow quitting Finder.
defaults write com.apple.finder QuitMenuItem -bool true

# When opening a new window, start in the home directory.
defaults write com.apple.finder NewWindowTarget -string 'PfHm'

# Keep folders on top when sorting by name. From https://github.com/sobolevn/dotfiles/blob/master/macos/settings.sh
defaults write com.apple.finder _FXSortFoldersFirst -bool TRUE

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

# Enable spring loading for directories, with no delay.
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Expand General section in Info panels for files and directories.
defaults write com.apple.finder FXInfoPanesExpanded -dict-add MetaData -bool true
# Enable (but don't expand by default) Sharing & Permissions section in Info panels for files and directories.
defaults write com.apple.finder FXInfoPanesExpanded -dict-add Privileges -bool false

# Show Sidebar, but remove the Tags section.
defaults write com.apple.finder ShowSidebar -bool true
defaults write com.apple.finder ShowRecentTags -bool false

# Make the Sidebar a little wider, so our favorites fit.
defaults write com.apple.finder SidebarWidth -int 175
defaults write com.apple.finder FK_SidebarWidth -int 175

# Set the favorites in the side bar of Finder windows, as well as Open/Save dialogs.
brew install --quiet mysides
mysides remove / >/dev/null # Oddly, AirDrop is named `/` here.
mysides remove Recents >/dev/null
mysides remove Home >/dev/null # Note that it's displayed with the username, not "Home".
mysides remove Applications >/dev/null
mysides remove Utilities >/dev/null
mysides remove Desktop >/dev/null
mysides remove Documents >/dev/null
mysides remove Downloads >/dev/null
mysides remove Projects >/dev/null
mysides remove Pictures >/dev/null
mysides remove Music >/dev/null
mysides remove Movies >/dev/null
mysides remove Screenshots >/dev/null
mysides remove Config >/dev/null
mysides remove Work >/dev/null
mysides remove Personal >/dev/null
mysides remove Developer >/dev/null
mysides remove Library >/dev/null

mysides add Home "file://$HOME/"
[[ -d "$HOME/Config Files" ]] || ln -s "$HOME/.config" "$HOME/Config Files"
mysides add 'Config Files' "file://$HOME/Config%20Files/"
[[ -d "$HOME/Developer" ]] || ln -s "$HOME/Work" "$HOME/Developer"
mysides add Developer "file://$HOME/Developer/"
[[ -d $HOME/Personal ]] && mysides add Personal "file://$HOME/Personal/"
mysides add Downloads "file://$HOME/Downloads/"
mysides add Pictures "file://$HOME/Pictures/"
mysides add Screenshots "file://$HOME/Pictures/Screenshots/"
mysides add Music "file://$HOME/Music/"
mysides add Library "file://$HOME/Library/"
mysides add Applications 'file:///Applications/'
mysides add Utilities 'file:///Applications/Utilities'
mysides add Recents 'file:///System/Library/CoreServices/Finder.app/Contents/Resources/MyLibraries/myDocuments.cannedSearch/'

# Prevent Time Machine from prompting to use new hard drives as backup volumes.
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Restart Finder so settings will take effect.
killall Finder
