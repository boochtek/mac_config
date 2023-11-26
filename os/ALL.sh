#!/bin/bash

# Make certain we're in the directory of this script.
cd "$(dirname $0)"

./xcode-clt.sh
./hostname.sh
./ui.sh
./finder.sh
./menubar.sh
./desktop.sh
./homebrew.sh
./1password.sh
./misc.sh
./defaults+.sh
./quicklook.sh
./dock.sh
./fonts.sh
./app_store.sh

cd -
