#!/bin/bash

# Cache the sudo password.
echo "$(tput setaf 4)You may be prompted for your sudo password.$(tput sgr0)"
sudo -v

# TODO: Make these idempotent. Use output of `pmset -g custom`.

## Power-saving settings. Times are in minutes.
## System Preferences > Energy Saver

# Set energy-saving features (on battery).
sudo pmset -b displaysleep 5 sleep 10

# Set energy-saving features (plugged in).
sudo pmset -c displaysleep 15 sleep 30

### Put the hard disk(s) to sleep when possible: 10 min
sudo pmset -b disksleep 10
sudo pmset -c disksleep 10

### Slightly dim the display when on battery
sudo pmset -b lessbright 0

### Automatically reduce brightness before display goes to sleep
sudo pmset -b halfdim 0
sudo pmset -c halfdim 0

### Restart automatically if the computer freezes (no longer available in MacOS 12 Monterey)
sudo pmset -b panicrestart 15 > /dev/null
sudo pmset -c panicrestart 15 > /dev/null

### Wake for network access
sudo pmset -c womp 1

### Start up automatically after a power failure
sudo pmset -c autorestart 1
