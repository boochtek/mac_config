#!/bin/bash

## Configure Terminal.app the way we want it.

## WARNING: This will kill any running Terminal session, in order for the settings to take effect.

## NOTES:
##  We override the default actions for the Home, End, PageUp, and PageDown keys - moving around in the buffer.
##  To move around in the buffer, use the Command key with the Home, End, PageUp, and PageDown keys.
##  To test from scratch, delete `~/Library/Preferences/com.apple.Terminal.plist` and `killall -u cfprefsd` and `killall Terminal`.


source 'ansi_codes.sh'
source 'key_codes.sh'


# Make sure we have latest defaults+.
curl --silent https://raw.github.com/boochtek/defaults_plus/master/defaults+ -o /usr/local/bin/defaults+
chmod a+x /usr/local/bin/defaults+
hash -r


function main {
  # Always show tabs, even if only 1 tab is open.
  defaults write -app Terminal ShowTabBar 1

  # Only use UTF-8 in Terminal.
  defaults write -app Terminal StringEncodings -array 4

  # Define ANSI sequences for cursor keys (with and without modifiers).
  bind_cursor_keys 'Basic'

  # Copy "Basic" profile to "BoochTek", and configure "BoochTek" the way we want it.
  defaults+ copy com.apple.Terminal 'Window Settings.Basic' 'Window Settings.BoochTek'
  defaults+ write com.apple.Terminal 'Window Settings.BoochTek.name' 'BoochTek'
  defaults+ write com.apple.Terminal 'Window Settings.BoochTek.CursorBlink' 1
  defaults+ write com.apple.Terminal 'Window Settings.BoochTek.Bell' 0
  defaults+ write com.apple.Terminal 'Window Settings.BoochTek.VisualBell' 1
  defaults+ write com.apple.Terminal 'Window Settings.BoochTek.columnCount' 120
  defaults+ write com.apple.Terminal 'Window Settings.BoochTek.rowCount' 32
  # TODO: Font: Courier New, Bold, 18 pt (or Menlo Regular 16, or a downloaded font)
  # Use the background color that the Solarized (Light) color scheme from Sublime Text uses.
  # defaults+ write com.apple.Terminal 'Window Settings.BoochTek.BackgroundColor' '<62706c69 73743030 d4010203 04050615 16582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0a3 07080f55 246e756c 6cd3090a 0b0c0d0e 554e5352 47425c4e 53436f6c 6f725370 61636556 24636c61 73734f10 26302e39 38343331 33373836 20302e39 35323934 31323338 3920302e 38373834 33313433 39340010 028002d2 10111213 5a24636c 6173736e 616d6558 24636c61 73736573 574e5343 6f6c6f72 a2121458 4e534f62 6a656374 5f100f4e 534b6579 65644172 63686976 6572d117 1854726f 6f748001 08111a23 2d32373b 41484e5b 628b8d8f 949fa8b0 b3bcced1 d6000000 00000001 01000000 00000000 19000000 00000000 00000000 00000000 d8>'

  # Copy "BoochTek" profile to "BoochTek Presentations", and change font and window sizes.
  # TODO: Do we want light and dark versions?
  defaults+ copy com.apple.Terminal 'Window Settings.Basic' 'Window Settings.BoochTek Presentations'
  defaults+ write com.apple.Terminal 'Window Settings.BoochTek Presentations.name' 'BoochTek Presentations'
  defaults+ write com.apple.Terminal 'Window Settings.BoochTek Presentations.columnCount' 80
  defaults+ write com.apple.Terminal 'Window Settings.BoochTek Presentations.rowCount' 24
  # TODO: Font: Courier New, Bold, 29 pt

  # Set default profile to use for new windows.
  defaults write -app Terminal 'Default Window Settings' -string 'BoochTek'
  defaults write -app Terminal 'Startup Window Settings' -string 'BoochTek'

  # Kill the preferences cache and Terminal app, so it will pick up new settings, and so it doesn't overwrite our changes.
  killall -u $USER cfprefsd
  killall -u $USER Terminal
}


# System-wide default bindings: /System/Library/Frameworks/AppKit.framework/Resources/StandardKeyBinding.dict 
# Actions specific to Terminal.app: /Applications/Utilities/Terminal.app/Contents/Resources/English.lproj/actions.strings
# Also see http://www.hcs.harvard.edu/~jrus/Site/system-bindings.html
# Also see http://xahlee.info/kbd/osx_keybinding_action_code.html and http://xahlee.info/kbd/osx_keybinding.html


# Where alternative bindings are possible, we're using the ones in the xterm terminfo (except BS).
function bind_cursor_keys {
  local PROFILE_NAME="$1"

  terminal_keybinding $PROFILE_NAME 'del' "${CSI}3~"
  # terminal_keybinding $PROFILE_NAME 'ins' "${CSI}2~"

  terminal_keybinding $PROFILE_NAME 'shift del' "${CSI}3;2~"  # CUA Cut
  # terminal_keybinding $PROFILE_NAME 'shift ins' "${CSI}2;2~"  # CUA Paste

  terminal_keybinding $PROFILE_NAME 'control bs'  "${ESC}?"     # Delete word to the left of cursor. From https://github.com/vmalloc/emacs_config/blob/master/.emacs.d/terminal-config.el
  terminal_keybinding $PROFILE_NAME 'control del' "${CSI}3;5~"  # Delete word to the right of cursor.
  # terminal_keybinding $PROFILE_NAME 'control ins' "${CSI}2;5~"  # CUA Copy

  terminal_keybinding $PROFILE_NAME 'up'      "${ESC}OA"  # Alternatives: "${CSI}A"
  terminal_keybinding $PROFILE_NAME 'down'    "${ESC}OB"  # Alternatives: "${CSI}B"
  terminal_keybinding $PROFILE_NAME 'right'   "${ESC}OC"  # Alternatives: "${CSI}C"
  terminal_keybinding $PROFILE_NAME 'left'    "${ESC}OD"  # Alternatives: "${CSI}D"
  terminal_keybinding $PROFILE_NAME 'home'    "${ESC}OH"  # Alternatives: "${CSI}H" (Mac default), "${CSI}1~"
  terminal_keybinding $PROFILE_NAME 'end'     "${ESC}OF"  # Alternatives: "${CSI}F" (Mac default), "${CSI}4~"
  terminal_keybinding $PROFILE_NAME 'pg_up'   "${CSI}5~"
  terminal_keybinding $PROFILE_NAME 'pg_down' "${CSI}6~"

  terminal_keybinding $PROFILE_NAME 'shift up'      "${CSI}1;2A"
  terminal_keybinding $PROFILE_NAME 'shift down'    "${CSI}1;2B"
  terminal_keybinding $PROFILE_NAME 'shift right'   "${CSI}1;2C"
  terminal_keybinding $PROFILE_NAME 'shift left'    "${CSI}1;2D"
  terminal_keybinding $PROFILE_NAME 'shift home'    "${CSI}1;2H"
  terminal_keybinding $PROFILE_NAME 'shift end'     "${CSI}1;2F"
  terminal_keybinding $PROFILE_NAME 'shift pg_up'   "${CSI}5;2~"
  terminal_keybinding $PROFILE_NAME 'shift pg_down' "${CSI}6;2~"

  terminal_keybinding $PROFILE_NAME 'option up'      "${CSI}1;3A"
  terminal_keybinding $PROFILE_NAME 'option down'    "${CSI}1;3B"
  terminal_keybinding $PROFILE_NAME 'option right'   "${CSI}1;3C"
  terminal_keybinding $PROFILE_NAME 'option left'    "${CSI}1;3D"
  terminal_keybinding $PROFILE_NAME 'option home'    "${CSI}1;3H"
  terminal_keybinding $PROFILE_NAME 'option end'     "${CSI}1;3F"
  terminal_keybinding $PROFILE_NAME 'option pg_up'   "${CSI}5;3~"
  terminal_keybinding $PROFILE_NAME 'option pg_down' "${CSI}6;3~"

  terminal_keybinding $PROFILE_NAME 'option shift up'      "${CSI}1;4A"
  terminal_keybinding $PROFILE_NAME 'option shift down'    "${CSI}1;4B"
  terminal_keybinding $PROFILE_NAME 'option shift right'   "${CSI}1;4C"
  terminal_keybinding $PROFILE_NAME 'option shift left'    "${CSI}1;4D"
  terminal_keybinding $PROFILE_NAME 'option shift home'    "${CSI}1;4H"
  terminal_keybinding $PROFILE_NAME 'option shift end'     "${CSI}1;4F"
  terminal_keybinding $PROFILE_NAME 'option shift pg_up'   "${CSI}5;4~"
  terminal_keybinding $PROFILE_NAME 'option shift pg_down' "${CSI}6;4~"

  terminal_keybinding $PROFILE_NAME 'control up'      "${CSI}1;5A"
  terminal_keybinding $PROFILE_NAME 'control down'    "${CSI}1;5B"
  terminal_keybinding $PROFILE_NAME 'control right'   "${CSI}1;5C"
  terminal_keybinding $PROFILE_NAME 'control left'    "${CSI}1;5D"
  terminal_keybinding $PROFILE_NAME 'control home'    "${CSI}1;5H"
  terminal_keybinding $PROFILE_NAME 'control end'     "${CSI}1;5F"
  terminal_keybinding $PROFILE_NAME 'control pg_up'   "${CSI}5;5~"
  terminal_keybinding $PROFILE_NAME 'control pg_down' "${CSI}6;5~"

  terminal_keybinding $PROFILE_NAME 'control shift up'      "${CSI}1;6A"
  terminal_keybinding $PROFILE_NAME 'control shift down'    "${CSI}1;6B"
  terminal_keybinding $PROFILE_NAME 'control shift right'   "${CSI}1;6C"
  terminal_keybinding $PROFILE_NAME 'control shift left'    "${CSI}1;6D"
  terminal_keybinding $PROFILE_NAME 'control shift home'    "${CSI}1;6H"
  terminal_keybinding $PROFILE_NAME 'control shift end'     "${CSI}1;6F"
  terminal_keybinding $PROFILE_NAME 'control shift pg_up'   "${CSI}5;6~"
  terminal_keybinding $PROFILE_NAME 'control shift pg_down' "${CSI}6;6~"

  terminal_keybinding $PROFILE_NAME 'control option up'      "${CSI}1;7A"
  terminal_keybinding $PROFILE_NAME 'control option down'    "${CSI}1;7B"
  terminal_keybinding $PROFILE_NAME 'control option right'   "${CSI}1;7C"
  terminal_keybinding $PROFILE_NAME 'control option left'    "${CSI}1;7D"
  terminal_keybinding $PROFILE_NAME 'control option home'    "${CSI}1;7H"
  terminal_keybinding $PROFILE_NAME 'control option end'     "${CSI}1;7F"
  terminal_keybinding $PROFILE_NAME 'control option pg_up'   "${CSI}5;7~"
  terminal_keybinding $PROFILE_NAME 'control option pg_down' "${CSI}6;7~"

  terminal_keybinding $PROFILE_NAME 'control option shift up'      "${CSI}1;8A"
  terminal_keybinding $PROFILE_NAME 'control option shift down'    "${CSI}1;8B"
  terminal_keybinding $PROFILE_NAME 'control option shift right'   "${CSI}1;8C"
  terminal_keybinding $PROFILE_NAME 'control option shift left'    "${CSI}1;8D"
  terminal_keybinding $PROFILE_NAME 'control option shift home'    "${CSI}1;8H"
  terminal_keybinding $PROFILE_NAME 'control option shift end'     "${CSI}1;8F"
  terminal_keybinding $PROFILE_NAME 'control option shift pg_up'   "${CSI}5;8~"
  terminal_keybinding $PROFILE_NAME 'control option shift pg_down' "${CSI}6;8~"
}


function terminal_keybinding {
  local profile="$1"
  local key_code=$(key_code_with_modifier "$2")
  local binding=$(echo -e "$3")  # Convert escape codes.
  local key_path="Window Settings.$profile.keyMapBoundKeys.$key_code"

  defaults+ write com.apple.Terminal "$key_path" "$binding"
}


main
