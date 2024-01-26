#! /bin/bash

# Allow Touch ID while screen sharing. From https://apple.stackexchange.com/a/444202/403766
defaults write com.apple.security.authorization ignoreArd -bool TRUE

# NOTE: You can't use sudo to call a function, so we do the sudo inside the function.
sudo_add_line_to_file_after() {
    local LINE_TO_ADD="$1"
    local FILE="$2"
    local AFTER="$3"
    if [ $# -ne 3 ]; then
        echo "Usage: sudo_add_line_to_file_after LINE_TO_ADD FILE AFTER"
        return 1
    fi

    grep --silent --line-regexp -F "$LINE_TO_ADD" "$FILE" || \
        sudo sed -i '.BAK' -e "/${AFTER}/ a\\
${LINE_TO_ADD}" "$FILE"
}

# Allow using Touch ID to authenticate to sudo.
# Suggested by https://azimi.io/how-to-enable-touch-id-for-sudo-on-macbook-pro-46272ac3e2df
if ! grep -q 'pam_tid' /etc/pam.d/sudo ; then
    echo 'Adding Touch ID support to /etc/pam.d/sudo'
    sudo_add_line_to_file_after \
        'auth       sufficient     pam_tid.so' \
        /etc/pam.d/sudo \
        'auth       sufficient     pam_smartcard.so'
fi
