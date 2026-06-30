#!/bin/bash

# Run from this script's own directory so each sub-script's relative paths resolve.
cd "$(dirname "$0")" || exit 1

# Chrome (and its extensions) is installed by ./chrome.sh, not ./browsers.sh.
./chrome.sh
./browsers.sh
# Firefox extensions and preferences are configured via Enterprise Policies.
# NOTE: Requires sudo to write into the Firefox app bundles.
./firefox.sh
./safari.sh
./tools.sh
./social.sh
./twitter.sh
