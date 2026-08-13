# This file is sourced to prepare to set up the Mac.

# This should work in Bash or Zsh (maybe others), but tell shellcheck it's Bash:
# shellcheck shell=bash

# Enable Touch ID for `sudo` before anything else needs it, so the rest of the
# setup authenticates with a fingerprint instead of repeated password prompts.
# Writing the PAM file itself needs root, so the very first `sudo` still asks for
# a password — that one prompt is unavoidable, and it is the only one.

# Return unless $HAS_TOUCH_ID is set to 1.
[[ "$HAS_TOUCH_ID" == "1" ]] || return 0

# Allow Touch ID while screen sharing. From https://apple.stackexchange.com/a/444202/403766
defaults write com.apple.security.authorization ignoreArd -bool TRUE

# Allow using Touch ID to authenticate to `sudo`.
#
# /etc/pam.d/sudo_local is Apple's supported drop-in (macOS 14+): the stock
# /etc/pam.d/sudo already ends up including it, and OS updates leave it alone.
# Editing /etc/pam.d/sudo directly works too, but every macOS update replaces
# that file and silently drops the setting.
#
# NOTE: pam_tid does not work inside tmux or screen without pam_reattach, and it
# cannot work at all over SSH — there is no way to offer a fingerprint to a
# remote session. Unattended runs need passwordless sudo instead.
if ! grep -q 'pam_tid' /etc/pam.d/sudo_local 2>/dev/null; then
    echo 'auth       sufficient     pam_tid.so' |
        sudo tee -a /etc/pam.d/sudo_local >/dev/null
fi
