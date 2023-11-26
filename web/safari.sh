# safari.sh

# Show the status bar at the bottom, so we can see URLs when we hover over links.
defaults write com.apple.Safari 'ShowStatusBar' -bool TRUE

# Don’t send search queries to Apple. From https://github.com/sobolevn/dotfiles/blob/master/macos/settings.sh
defaults write com.apple.Safari 'UniversalSearchEnabled' -bool FALSE
defaults write com.apple.Safari 'SuppressSearchSuggestions' -bool TRUE

# Disable Java.
defaults write com.apple.Safari 'com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled' -bool FALSE
defaults write com.apple.Safari 'com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles' -bool FALSE

# Enable all the development settings.
defaults write com.apple.Safari 'IncludeInternalDebugMenu' -bool TRUE
defaults write com.apple.Safari 'IncludeDevelopMenu' -bool TRUE
defaults write com.apple.Safari 'WebKitDeveloperExtrasEnabledPreferenceKey' -bool TRUE
defaults write com.apple.Safari 'com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled' -bool TRUE
defaults write NSGlobalDomain 'WebKitDeveloperExtras' -bool TRUE
