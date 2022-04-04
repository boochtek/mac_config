#!/bin/bash

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

### Restart automatically if the computer freezes
sudo pmset -b panicrestart 15
sudo pmset -c panicrestart 15

### Wake for network access
sudo pmset -c womp 1

### Start up automatically after a power failure
sudo pmset -c autorestart 1
