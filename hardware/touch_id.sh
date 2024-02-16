#! /bin/bash

# Allow Touch ID while screen sharing. From https://apple.stackexchange.com/a/444202/403766
defaults write com.apple.security.authorization ignoreArd -bool TRUE

# Allow using Touch ID to authenticate to sudo.
# Suggested by https://azimi.io/how-to-enable-touch-id-for-sudo-on-macbook-pro-46272ac3e2df
if ! grep -q 'pam_tid' /etc/pam.d/sudo ; then
    sudo sed -i '' '/^auth       sufficient     pam_smartcard.so/i \
auth       sufficient     pam_tid.so
' /etc/pam.d/sudo
fi
