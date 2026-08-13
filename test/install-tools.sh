#!/bin/bash

# Install host-side tooling for VM-based testing of the setup scripts.
#
# Currently just `tart` (a CLI-first macOS VM manager built on Apple's
# Virtualization.framework). Idempotent: safe to re-run.

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" >&2 ; exit $RC' ERR

# tart and its `softnet` dependency come from the cirruslabs/cli tap. Homebrew's
# tap-trust gate requires explicitly trusting them before install.
if ! command -v tart; then
    brew trust --formula cirruslabs/cli/tart cirruslabs/cli/softnet
    brew install cirruslabs/cli/tart
fi

tart --version
