#!/bin/bash

RUBY_VERSION="${RUBY_VERSION:-3.1.1}"
RUBY2_VERSION="${RUBY2_VERSION:-2.7.5}"

# Dependencies: `asdf`

## Install and configure various versions of Ruby.
asdf plugin update ruby
asdf install ruby "$RUBY_VERSION"
asdf install ruby "$RUBY2_VERSION"
# TODO: See if there are any old versions we want to get rid of. Maybe ask?
#           Use `asdf uninstall ruby 2.7.1`
#           Maybe set an `at` to remind you to run the script again?


## Gems

# NOTE: The asdf Ruby plugin installs all the gems listed in `~/.default-gems`
# Install some gems for every version of Ruby. These are either for irb or for the commands they provide,
GEMS_TO_INSTALL='bundler amazing_print hirb wirble pry railties rubocop debug'
ALL_RUBY_VERSIONS="$(asdf list ruby | tr -d '\n')"
CURRENT_RUBY_VERSION=$(asdf current ruby | awk '{print $2}' | tr -d '\n')
if [[ -z "$CURRENT_RUBY_VERSION" ]]; then
    CURRENT_RUBY_VERSION=system
fi
for ruby_version in $ALL_RUBY_VERSIONS ; do
    asdf shell ruby $ruby_version
    echo "Installing gems into $ruby_version: $GEMS_TO_INSTALL"
    gem update --system
    gem update bundler
    gem install $GEMS_TO_INSTALL
done

# Install some gems for ONLY the latest Ruby.
asdf shell ruby $CURRENT_RUBY_VERSION
brew install --no-quarantine --cask wkhtmltopdf
gem install kramdown
gem install rsense
gem install ruby-beautify
gem install middleman
gem install railties
