#!/bin/bash

set -euo pipefail; IFS=$'\n\t'

# This adds the `ip` command. Note that it's incomplete, compared to the Linux version.
#   `ip address`
#   `ip route`
# NOTE: This port does not include the `ss` (socket statistics) command.
brew install --quiet iproute2mac

# Netcat is useful for testing and using TCP ports.
brew install --quiet netcat

# NOTE: The `netstat` that comes with MacOS is more limited than the Linux variant.
# Use `lsof -sTCP:LISTEN -iTCP -nP` as the equivalent of `netstat -plant`
# Or `netstat -p tcp -van | grep '^Proto\|LISTEN'`