#! /bin/bash

source "${BASH_SOURCE%/*}/../os/homebrew.sh"

# Cache the sudo password.
echo "$(tput setaf 4)You may be prompted for your sudo password.$(tput sgr0)"
sudo -v

# Siege is an HTTP load testing and benchmarking tool.
brew install --quiet siege

# HTTPie is like cURL, but better for working with APIs.
# NOTE: HTTPie also has a GUI front-end, available as a cask.
brew install --quiet httpie
