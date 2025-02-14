#!/bin/bash

brew install --quiet --cask --no-quarantine 1password
brew install --quiet 1password-cli

# TODO: Use this for virtualOS too.
mas_install() {
    local app_name="$1"
    local app_id
    app_id="$(mas search "${app_name}" | grep "${app_name}" | awk '{ print $1 }')"
    mas purchase "${app_id}"
    mas install "${app_id}"
}

mas_install '1Password for Safari'


# TODO: Install other browser extensions.
# TODO: Document using 1Password's SSH agent.
# TODO: Integrate CLI. Figure out where it got installed to.
# TODO: Allow CLI to use Touch ID.
