#!/bin/bash

## Helper functions for working with Mac OS X key codes.
## These are used in Terminal.app and Library/KeyBindings/DefaultKeyBinding.Dict, among other places.


source 'maps.sh'
source 'arrays.sh'


# Apple (and previously NeXT) uses "private use" Unicode characters to represent function keys.
# See http://www.unicode.org/Public/MAPPINGS/VENDORS/APPLE/CORPCHAR.TXT for full documentation.
# They're also defined in `NSEvent.h`, apparently.
# NOTE: This list is not complete, but includes all keys on commonly used keyboards.
# Also see /Applications/Utilities/Terminal.app/Contents/Resources/English.lproj/keys.strings
KEY_CODES=(
  'f1=F704'
  'f2=F705'
  'f3=F706'
  'f4=F707'
  'f5=F708'
  'f6=F709'
  'f7=F70A'
  'f8=F70B'
  'f9=F70C'
  'f10=F70D'
  'f11=F70E'
  'f12=F70F'
  'f13=F710'
  'f14=F711'
  'f15=F712'
  'f16=F713'
  'f17=F714'
  'f18=F715'
  'f19=F716'
  'f20=F717'
  'up=F700'
  'down=F701'
  'left=F702'
  'right=F703'
  'home=F729'
  'end=F72B'
  'pageup=F72C'
  'pagedown=F72D'
  'page_up=F72C'
  'page_down=F72D'
  'pgup=F72C'
  'pgdown=F72D'
  'pg_up=F72C'
  'pg_down=F72D'
  'delete=007F'
  'backspace=007F'
  'bs=007F'
  'forwarddelete=F728'
  'forward_delete=F728'
  'del=F728'
  'help=F746'
  'insert=F746'   # Might be mapped to F727 instead.
  'ins=F746'
  'tab=0011'
  'clear=F739'
  'numlock=F739'
  'num_lock=F739'
)


# Apple documentation for these is at https://developer.apple.com/library/mac/documentation/cocoa/conceptual/eventoverview/TextDefaultsBindings/TextDefaultsBindings.html.
# The docs at http://heisencoder.net/2008/04/fixing-up-mac-key-bindings-for-windows.html are better though - including the Command key.
# Note that the order they're listed is the order they need to be used within a shortcut definition.
# Also see http://xahlee.info/kbd/osx_keybinding_key_syntax.html
# Also see /Applications/Utilities/Terminal.app/Contents/Resources/English.lproj/modifierDescriptions.strings
MODIFIERS=(
  'command=@'
  'apple=@'
  'option=~'
  'alt=~'
  'control=^'
  'shift=$'
  'numpad=#'
  'num=#'
  'keypad=#'
)


# Given a key description in English, output a keycode with modifier prefix.
# For example, "Control Shift F1" would output "^$F704".
function key_code_with_modifier {
  local key_description=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  local prefix=$(modifier_prefix "$key_description")
  local key_code=$(map_value_for_key "${KEY_CODES[@]}" "$(last_word "$key_description")")
  echo "${prefix}${key_code}"
}


function modifier_prefix {
  local key_description=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  local modifier_names=($key_description)
  local modifier

  for modifier in $(map_keys "${MODIFIERS[@]}"); do
    if array_contains "$modifier" "${modifier_names[@]}"; then
      echo -n $(map_value_for_key "${MODIFIERS[@]}" "$modifier")
    fi
  done
}


function last_word {
  echo "$1" | awk '{print $NF}'
}
