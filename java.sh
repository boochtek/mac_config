#!/bin/bash

## Install and configure Java.


# Cache the sudo password, as we'll need it to install Java.
sudo -v

# Install Java 8. (Requires sudo.)
brew cask install java

# Install Java 7. (Requires sudo.)
brew cask install java7
