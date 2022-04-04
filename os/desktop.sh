#!/bin/bash

# Don't bother with the "desktop" behind all our windows. From http://lifehacker.com/hide-and-show-desktop-icons-on-os-x-with-an-automator-s-5704241
defaults write com.apple.finder CreateDesktop false

# Don't show any special icons on desktop.
defaults write ShowExternalHardDrivesOnDesktop -bool false
defaults write ShowHardDrivesOnDesktop -bool false
defaults write ShowRemovableMediaOnDesktop -bool false
defaults write ShowMountedServersOnDesktop -bool false

brew install wallpaper

# TODO: Find this wallpaper image again, or a suitable replacement.

#- name: Download wallpaper image
#  get_url:
#    url: http://pic.1fotonin.com//data/wallpapers/20/WDF_683106.jpg
#    dest: "~/Pictures/WDF_683106.jpg"
#
#- name: Set wallpaper image
#  command: wallpaper "~/Pictures/WDF_683106.jpg"
#  changed_when: FALSE

killall Finder
