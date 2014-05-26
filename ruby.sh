#!/bin/bash

## Install and configure various versions of Ruby.


source 'homebrew.sh'


## Ruby (various versions)

# Install various versions of Ruby.
brew install ruby-install
ruby-install --no-reinstall ruby 1.9.3
ruby-install --no-reinstall ruby 2.0
ruby-install --no-reinstall ruby 2.1
ruby-install --no-reinstall rbx 2.2
ruby-install --no-reinstall jruby 1.7

# If you need Ruby 1.9.3-p125:
#brew install gcc46
#ruby-install ruby 1.9.3-p125 -- CC=gcc-4.6
#brew uninstall gcc46 gmp4 mpfr2 libmpc08 ppl011 cloog-ppl015


## Chruby (for switching between Ruby versions)

# We'll use chruby to allow us to easily switch between various versions of Ruby.
brew install chruby

# Allow this shell to use chruby automatically.
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Ensure new bash shells use chruby automatically.
grep -q 'chruby' ~/.bashrc || cat >> ~/.bashrc <<'EOF'

# Automatically change Ruby versions when changing directories. Set a default Ruby version.
if [[ -d /usr/local/share/chruby ]]; then
    source /usr/local/share/chruby/chruby.sh
    source /usr/local/share/chruby/auto.sh
    chruby 2.1
fi
EOF


## Gems

# Install some gems for every version of Ruby. These are either for irb or for the commands they provide,
GEMS_TO_INSTALL='rake bundler awesome_print hirb wirble pry rails haml html2haml'
ALL_RUBY_VERSIONS=$(chruby | sed -e 's/*//' | awk '{print $1}')
CURRENT_RUBY_VERSIONS=$(chruby | grep '*' | awk '{print $2}' | tr -d '\n')
if [[ -z "$CURRENT_RUBY_VERSION" ]]; then
    CURRENT_RUBY_VERSION=system
fi
for ruby_version in $ALL_RUBY_VERSIONS ; do
    chruby $ruby_version
    echo "Installing gems into $ruby_version: $GEMS_TO_INSTALL"
    gem install $GEMS_TO_INSTALL
done
chruby $CURRENT_RUBY_VERSION
