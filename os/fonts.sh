#!/bin/bash

source "${BASH_SOURCE%/*}/../os/homebrew.sh"

brew install --quiet fontconfig
brew install --quiet svn # required to install some fonts

## Install additional fonts.
brew install --quiet --cask --no-quarantine niksy/pljoska/font-microsoft-cleartype-family
brew install --quiet --cask --no-quarantine font-comic-mono
brew install --quiet font-jetbrains-mono
brew install --quiet font-fira-code
brew install --quiet --cask --no-quarantine font-anonymous-pro
brew install --quiet --cask --no-quarantine font-fira-mono
brew install --quiet --cask --no-quarantine font-fira-sans
brew install --quiet --cask --no-quarantine font-awesome-terminal-fonts
brew install --quiet --cask --no-quarantine font-bitstream-vera
brew install --quiet --cask --no-quarantine font-courier-prime
brew install --quiet --cask --no-quarantine font-courier-prime-code
brew install --quiet --cask --no-quarantine font-courier-prime-medium-and-semi-bold
brew install --quiet --cask --no-quarantine font-courier-prime-sans
brew install --quiet --cask --no-quarantine font-dejavu
brew install --quiet --cask --no-quarantine font-dm-mono
brew install --quiet --cask --no-quarantine font-dm-sans
brew install --quiet --cask --no-quarantine font-dm-serif-display
brew install --quiet --cask --no-quarantine font-dm-serif-text
brew install --quiet --cask --no-quarantine font-fantasque-sans-mono
brew install --quiet --cask --no-quarantine font-gnu-unifont
brew install --quiet --cask --no-quarantine font-go
brew install --quiet --cask --no-quarantine font-hack
brew install --quiet --cask --no-quarantine font-hasklig
brew install --quiet --cask --no-quarantine font-ia-writer-duo
brew install --quiet --cask --no-quarantine font-ia-writer-mono
brew install --quiet --cask --no-quarantine font-ia-writer-quattro
brew install --quiet --cask --no-quarantine font-ibm-plex-mono
brew install --quiet --cask --no-quarantine font-ibm-plex-sans
brew install --quiet --cask --no-quarantine font-ibm-plex-serif
brew install --quiet --cask --no-quarantine font-inconsolata
brew install --quiet --cask --no-quarantine font-inria
brew install --quiet --cask --no-quarantine font-inria-sans
brew install --quiet --cask --no-quarantine font-inria-serif
# Iosevka - sans-serif + slab-serif, monospace + quasi‑proportional, designed for code & terminals, ligatures. Variants mimic other fonts.
brew install --quiet --cask --no-quarantine font-iosevka
brew install --quiet --cask --no-quarantine font-iosevka-ss01
brew install --quiet --cask --no-quarantine font-iosevka-ss02
brew install --quiet --cask --no-quarantine font-iosevka-ss03
brew install --quiet --cask --no-quarantine font-iosevka-ss04
brew install --quiet --cask --no-quarantine font-iosevka-ss05
brew install --quiet --cask --no-quarantine font-iosevka-ss06
brew install --quiet --cask --no-quarantine font-iosevka-ss07
brew install --quiet --cask --no-quarantine font-iosevka-ss08
brew install --quiet --cask --no-quarantine font-iosevka-ss09
brew install --quiet --cask --no-quarantine font-iosevka-ss10
brew install --quiet --cask --no-quarantine font-iosevka-ss11
brew install --quiet --cask --no-quarantine font-iosevka-ss12
brew install --quiet --cask --no-quarantine font-iosevka-ss13
brew install --quiet --cask --no-quarantine font-iosevka-ss14
brew install --quiet --cask --no-quarantine font-iosevka-ss15
brew install --quiet --cask --no-quarantine font-iosevka-ss16
brew install --quiet --cask --no-quarantine font-iosevka-ss17
brew install --quiet --cask --no-quarantine font-iosevka-ss18
brew install --quiet --cask --no-quarantine font-latin-modern
brew install --quiet --cask --no-quarantine font-latin-modern-math
brew install --quiet --cask --no-quarantine font-lavishly-yours
brew install --quiet --cask --no-quarantine font-league-gothic
brew install --quiet --cask --no-quarantine font-league-mono
brew install --quiet --cask --no-quarantine font-league-script
brew install --quiet --cask --no-quarantine font-league-spartan
brew install --quiet --cask --no-quarantine font-lexend
brew install --quiet --cask --no-quarantine font-liberation
brew install --quiet --cask --no-quarantine font-linux-biolinum
brew install --quiet --cask --no-quarantine font-linux-libertine
brew install --quiet --cask --no-quarantine font-luxurious-script
brew install --quiet --cask --no-quarantine font-monoid
# Mononoki is a font "for programming and code review".
brew install --quiet --cask --no-quarantine font-mononoki
brew install --quiet --cask --no-quarantine font-noto-mono
brew install --quiet --cask --no-quarantine font-noto-music
brew install --quiet --cask --no-quarantine font-noto-sans
brew install --quiet --cask --no-quarantine font-noto-sans-display
brew install --quiet --cask --no-quarantine font-noto-sans-mono
brew install --quiet --cask --no-quarantine font-noto-serif
# NOTE: Following failed to install due to missing `svn` package.
brew install --quiet --cask --no-quarantine font-open-sans
brew install --quiet --cask --no-quarantine font-overpass
brew install --quiet --cask --no-quarantine font-overpass-mono
brew install --quiet --cask --no-quarantine font-oxygen-mono
brew install --quiet --cask --no-quarantine font-pt-mono
brew install --quiet --cask --no-quarantine font-pt-sans
brew install --quiet --cask --no-quarantine font-pt-sans-caption
brew install --quiet --cask --no-quarantine font-pt-sans-narrow
brew install --quiet --cask --no-quarantine font-pt-serif
brew install --quiet --cask --no-quarantine font-pt-serif-caption
brew install --quiet --cask --no-quarantine font-quattrocento
brew install --quiet --cask --no-quarantine font-quattrocento-sans
brew install --quiet --cask --no-quarantine font-recursive-code
brew install --quiet --cask --no-quarantine font-red-hat-display
brew install --quiet --cask --no-quarantine font-red-hat-mono
brew install --quiet --cask --no-quarantine font-red-hat-text
brew install --quiet --cask --no-quarantine font-roboto-flex
brew install --quiet --cask --no-quarantine font-roboto-mono
brew install --quiet --cask --no-quarantine font-roboto-serif
brew install --quiet --cask --no-quarantine font-roboto-slab
# SF and New York fonts are from Apple. May require sudo access.
brew install --quiet --cask --no-quarantine font-sf-mono
brew install --quiet --cask --no-quarantine font-sf-pro
brew install --quiet --cask --no-quarantine font-new-york
brew install --quiet --cask --no-quarantine font-sometype-mono
brew install --quiet --cask --no-quarantine font-source-code-pro
brew install --quiet --cask --no-quarantine font-source-sans-3
brew install --quiet --cask --no-quarantine font-source-sans-pro
brew install --quiet --cask --no-quarantine font-source-serif-4
brew install --quiet --cask --no-quarantine font-source-serif-pro
brew install --quiet --cask --no-quarantine font-stix
brew install --quiet --cask --no-quarantine font-stix-two-math
brew install --quiet --cask --no-quarantine font-stix-two-text
brew install --quiet --cask --no-quarantine font-sudo
brew install --quiet --cask --no-quarantine font-terminus
brew install --quiet --cask --no-quarantine font-times-newer-roman
brew install --quiet --cask --no-quarantine font-tinos
brew install --quiet --cask --no-quarantine font-titillium-web
brew install --quiet --cask --no-quarantine font-tt2020
brew install --quiet --cask --no-quarantine font-ubuntu
brew install --quiet --cask --no-quarantine font-ubuntu-condensed
brew install --quiet --cask --no-quarantine font-ubuntu-mono
brew install --quiet --cask --no-quarantine font-victor-mono
brew install --quiet --cask --no-quarantine font-vt323
brew install --quiet --cask --no-quarantine font-work-sans

# Icon fonts.
brew install --quiet --cask --no-quarantine font-fontawesome
brew install --quiet --cask --no-quarantine font-powerline-symbols
brew install --quiet font-noto-color-emoji
brew install --quiet --cask --no-quarantine font-twitter-color-emoji
brew install --quiet --cask --no-quarantine font-ligature-symbols
brew install --quiet --cask --no-quarantine font-codicon   # from MS VS Code
brew install --quiet --cask --no-quarantine font-devicons
brew install --quiet --cask --no-quarantine font-foundation-icons # from Zurb Foundation
brew install --quiet --cask --no-quarantine font-open-iconic

# Flow is meant to be used in creating wireframes.
brew install --quiet --cask --no-quarantine font-flow-block
brew install --quiet --cask --no-quarantine font-flow-circular
brew install --quiet --cask --no-quarantine font-flow-rounded

# Humor Sans is meant to look like the font used in XKCD.
brew install --quiet --cask --no-quarantine font-humor-sans
