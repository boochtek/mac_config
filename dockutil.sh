#!/bin/bash

# Make sure we have latest dockutil.

curl -k -o /usr/local/bin/dockutil https://raw.githubusercontent.com/kcrawford/dockutil/master/scripts/dockutil
chmod a+x /usr/local/bin/dockutil
hash -r

