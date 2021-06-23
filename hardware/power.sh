#!/bin/bash

# TODO: Make these idempotent. Use output of `pmset -g custom`.

## Power-saving settings. Times are in minutes.

# Set energy-saving features (on battery).
sudo pmset -b displaysleep 5 sleep 10

# Set energy-saving features (plugged in).
sudo pmset -c displaysleep 15 sleep 30
