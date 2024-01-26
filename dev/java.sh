#!/bin/bash

### Install and configure Java.

# For now, we're just installing the latest OpenJDK.
# If we need older versions, `openjdk@17`, `openjdk@11`, `openjdk@8`, and `java6` (cask) are available.
# If we need the Oracle JDK, `oracle-jdk` is available as a cask.
# Several other JDKs are available. See `brew search jdk ; brew search java`.

## Install the latest OpenJDK.
brew install --quiet openjdk

# Set the OpenJDK as your system Java:
sudo ln -sfn "$(brew --prefix)/opt/openjdk/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk.jdk

# Alternatively, we could set `JAVA_HOME` and `PATH`, to choose anything JDK.
# We could also use `jenv` to manage multiple Java versions.
