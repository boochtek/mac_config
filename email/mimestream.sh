#!/bin/bash

set -euo pipefail; IFS=$'\n\t'


# Install Mimestream, which has extensive Gmail support.
brew install --quiet --cask --no-quarantine mimestream

dockutil --add  '/Applications/Mimestream.app' --replacing 'Mimestream' --after Calendar
open -a Mimestream