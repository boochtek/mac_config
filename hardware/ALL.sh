#!/bin/bash

# Run from this script's own directory so each sub-script's relative paths resolve.
cd "$(dirname "$0")" || exit 1

# NOTE: key_codes.sh is a sourced helper (key-code maps), not a standalone installer.
# NOTE: Touch ID is configured in init/touch-id.sh, early enough that the rest of
#       the setup can authenticate sudo with a fingerprint.

./display.sh
./keyboard.sh
./pedals.sh
./power.sh
./qmk.sh
./touchbar.sh
./trackpad.sh
