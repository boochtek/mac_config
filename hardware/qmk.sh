#!/bin/bash

# Install everything needed to re-program my QMK keyboards.
for tap in qmk/qmk osx-cross/arm osx-cross/avr ; do
    brew tap $tap
    brew trust $tap
done

brew install --quiet qmk
