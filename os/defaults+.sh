#!/bin/bash

# Enable strict mode + error trap only when run directly, not when sourced.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    set -Euo pipefail
    IFS=$'\n\t'
    [[ -n "${DEBUG+unset}" ]] && set -x
    trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" >&2 ; exit $RC' ERR
fi

# Make sure we have latest defaults+.

sudo chown root:staff /usr/local/bin
sudo chmod g+w /usr/local/bin
curl --silent -o /usr/local/bin/defaults+ https://raw.githubusercontent.com/boochtek/defaults_plus/master/defaults+
chmod a+x /usr/local/bin/defaults+
python3 -m pip install pyobjc
hash -r
