#!/bin/bash

### Install and configure Java.

# For now, we're just installing the latest OpenJDK.
# If we need older versions, `openjdk@11`, `openjdk@8`, and `java6` (cask) are available.
# If we need the Oracle JDK, `oracle-jdk` is available as a cask.
# You'll need to set `JAVA_HOME` and `PATH`, to choose anything other than the system-supplied Java.

## Install the latest OpenJDK.
brew install openjdk
