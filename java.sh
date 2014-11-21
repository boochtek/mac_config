#!/bin/bash

## Install and configure Java.

# NOTE: The last installed version will apparently become the default.
# NOTE: To select the version of Java to use, set JAVA_HOME, as below.


# Install Java 6. (Requires sudo and interactive GUI.)
# NOTE: To use Java 6, set JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
brew cask install java6
open "/opt/homebrew-cask/Caskroom/java6/1.6.0_65/JavaForOSX.pkg"

# Install Java 7. (Requires sudo and interactive GUI.)
# NOTE: To use Java 7, set JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
brew cask install java7
open "/opt/homebrew-cask/Caskroom/java7/1.7.0_72/JDK 7 Update 72.pkg"

# Install Java 8. (Requires sudo and interactive GUI.)
# NOTE: To use Java 8, unset JAVA_HOME.
brew cask install java
open "/opt/homebrew-cask/Caskroom/java/1.8.0_25/JDK 8 Update 25.pkg"
