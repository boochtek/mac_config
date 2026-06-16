#!/bin/bash

# Run from this script's own directory so each sub-script's relative paths resolve.
cd "$(dirname "$0")" || exit 1

# NOTE: key_codes.sh is a sourced helper (key-code maps), not a standalone installer.

./display.sh
./keyboard.sh
./pedals.sh
./power.sh
./qmk.sh
./touch_id.sh
./touchbar.sh
./trackpad.sh
