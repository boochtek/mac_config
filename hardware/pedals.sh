#!/bin/bash

# NOTE: You'll be prompted for your password.
brew install --quiet --cask --no-quarantine elgato-stream-deck

# NOTE: The app will open, and will likely prompt you to install an update.
# NOTE: You'll get a prompt that the app (from "Corsair") will run in the background.
# NOTE: Allow Elgato Stream Deck to have full Accessibility in Privacy & Security

# TODO: Installed MuteKey via App Store

# TODO: Add plugins
    # * Audio Mute
    # * Mute Deck
        # * NOTE: Requires downloading and installing https://mutedeck.com/downloads
        # * NOTE: MuteDeck will be added to login items
        # * The instructions are wrong - allow MuteDeck to have full Accessibility in Privacy & Security
    # * Visual Studio Code
    # * Shortcuts
    # * Zoom
        # NOTE: Click ALLOW on “Elgato Stream Deck.app” wants access to control “System Events.app”. Allowing control will provide access to documents and data in “System Events.app”, and to perform actions within that app.

# --------

# Ikkegol Pedals

# Manual:
#   Download latest MacOS version of ElfKey from https://pcsensor.com/download?_l=en
#       For Apple Silicon on 2023-07-26: https://rding.obs.ap-southeast-1.myhuaweicloud.com/downloads/ElfKey/ElfKey-1.9.0-mac-arm64.dmg
#   Open the DMG file
#   Copy the app to /Applications
#   Open the ElfKey app
#       Select the FS2020 foot pedal
#       Set left   to Control+Option+Command+F13 (PrtScrn)
#       Set middle to Control+Option+Command+F14 (ScrLock)
#       Set right  to Control+Option+Command+F15 (Pause)
#   Close and delete the app


# BetterTouchTool
brew install --quiet --cask --no-quarantine bettertouchtool
open -a BetterTouchTool
# Manually:
#   Check for Updates
#   Hit OK when asked to control "Shortcut Events.app"
#   Hit *Continue* to confirm GDPR privacy statement
#   Hit the button to open System Preferences / Security & Privacy / Accessibility
#       Enable BetterTouchTool
#   Prompt "BetterTouchTool.app" would like to receive keystrokes from any application
#       Click on Open system Settings to open System Preferences / Security & Privacy / Input Monitoring
#           Hit the + and add BetterTouchTool.
#   Settings
#       Basic
#           CHECK Launch BetterTouchTool on startup
#           CHECK Allow crash log and anonymized usage data collection
#           CHECK Silently download & install updates on restart
#