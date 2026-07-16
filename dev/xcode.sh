#!/bin/bash

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR

## Ensure XCode Command Line Tools are installed.


if [[ ! -x /Library/Developer/CommandLineTools/usr/bin/clang ]]; then
    XCODE_INSTALL='/tmp/xcode-cli-tools.sh'
    XCODE_INSTALL_SCRIPT_URL='https://raw.githubusercontent.com/timsutton/osx-vm-templates/master/scripts/xcode-cli-tools.sh'
    curl -o $XCODE_INSTALL $XCODE_INSTALL_SCRIPT_URL
    sh $XCODE_INSTALL
    rm $XCODE_INSTALL
fi

brew install --quiet xcodegen
