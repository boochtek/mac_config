#!/bin/bash

# TODO: Install via ASDF.

## Io
# Install the required XQuartz first. NOTE: Requires password interactively.
brew install --quiet --cask --no-quarantine xquartz
# Install the language itself.
brew install io
