# This file is sourced to prepare to set up the Mac.

# This should work in Bash or Zsh (maybe others), but tell shellcheck it's Bash:
# shellcheck shell=bash

# Make sure we have Xcode Command Line Tools installed.
# TODO: Should we use `pkgutil` here (like below) instead of `xcode-select -p`?
# TODO: Homebrew looks for /Library/Developer/CommandLineTools/usr/bin/clang; we should use git.
#           See https://github.com/Homebrew/brew/blob/master/Library/Homebrew/os/mac/xcode.rb
#           They get the version with `/usr/sbin/pkgutil --pkg-info com.apple.pkg.CLTools_Executables`
#               and if the version is empty, they install the tools.
if ! xcode-select --print-path > /dev/null ; then
    echo 'Installing Xcode Command Line Tools. NOTE: This may take a while. Follow prompts.'

    while ! pkgutil --pkg-info=com.apple.pkg.CLTools_Executables > /dev/null ; do
        if [ -z "$xcode_cli_installing" ]; then
            xcode-select --install
            xcode_cli_installing='yes'
        else
            sleep 1
        fi
    done
    echo 'Xcode Command Line Tools have been installed.'
fi
