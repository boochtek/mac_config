#!/bin/bash

# Make certain we're in the directory of this script.
cd "$(dirname $0)"

./xcode-clt.sh
./homebrew.sh
./hostname.sh
./security.sh
./ui.sh
./finder.sh
./menubar.sh
./desktop.sh
./1password.sh
./clipboard.sh
./misc.sh
./defaults+.sh
./quicklook.sh
./dock.sh
./network.sh
./fonts.sh
./app_store.sh
./virtualization.sh

cd -
