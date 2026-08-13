# This file is sourced to prepare to set up the Mac.

# This should work in Bash or Zsh (maybe others), but tell shellcheck it's Bash:
# shellcheck shell=bash

# Make sure we have Xcode Command Line Tools installed. Homebrew needs them: it
# looks for /Library/Developer/CommandLineTools/usr/bin/clang, and checks the
# package the same way we do below. See https://github.com/Homebrew/brew/blob/master/Library/Homebrew/os/mac/xcode.rb

install_command_line_tools() {
    if xcode-select --print-path >/dev/null 2>&1; then
        # Already installed!
        return 0
    fi

    echo 'Installing Xcode Command Line Tools. NOTE: This may take a while.'

    # If we have a GUI, default to Apple's own installer — a progress dialog,
    # no password prompt. Fall back to headless path only if that fails.
    # Unattended runs get the reverse, since a dialog nobody can click just hangs.
    if gui_session_available; then
        install_command_line_tools_gui || {
            echo 'GUI install did not complete; trying the headless installer.'
            install_command_line_tools_headless
        }
    else
        install_command_line_tools_headless || {
            echo 'Headless install failed; trying the GUI installer.'
            install_command_line_tools_gui
        }
    fi

    if command_line_tools_installed; then
        echo 'Xcode Command Line Tools have been installed.'
    else
        echo 'ERROR: Command Line Tools are still missing; git and Homebrew will fail.' >&2
        return 1
    fi
}

# Install the Command Line Tools without a GUI.
#
# `xcode-select --install` asks the *window server* to show a dialog, so it fails
# outright over SSH ("no install could be requested (perhaps no UI is present)"),
# as in a test VM. `softwareupdate` installs the same package headlessly. The
# placeholder file is the documented trick that makes the CLT package appear in
# the update list; Apple's installer creates it too.
install_command_line_tools_headless() {
    local placeholder='/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress'
    local label attempt

    touch "$placeholder"
    # Last entry is the newest when several versions are offered.
    label="$(softwareupdate --list 2>/dev/null |
        awk -F'Label: ' '/Label: Command Line Tools/ {print $2}' |
        tail -1)"
    if [ -z "$label" ]; then
        rm -f "$placeholder"
        return 1
    fi

    echo "Installing: $label"
    echo "  This downloads ~1 GB and takes several minutes."
    echo "  To watch progress, from another shell on this machine run:"
    echo "      tail -f /var/log/install.log | grep -E 'Starting download|Verifying'"

    # Apple's CDN fails often ("PKDownloadError error 8") — especially in a VM.
    for attempt in 1 2 3; do
        [ "$attempt" -gt 1 ] && echo "Download failed; retrying (attempt $attempt of 3)."
        sudo softwareupdate --install "$label" --verbose
        # WARNING: softwareupdate may report "Error downloading updates" and still exit 0.
        # So we need to check whether the tools actually got installed.
        if command_line_tools_installed; then
            rm -f "$placeholder"
            return 0
        fi
        [ "$attempt" -lt 3 ] && sleep 30
    done

    rm -f "$placeholder"
    return 1
}

# Ask macOS to show its own installer dialog, and wait for someone to work it.
# Preferred when someone is at the keyboard: a progress dialog rather than
# terminal output, and no password prompt. Needs a GUI session, so unattended
# runs use the headless path instead.
install_command_line_tools_gui() {
    local waited=0

    echo 'Requesting the GUI installer. Follow the prompts.'
    xcode-select --install

    # Wait for the install to finish, but don't spin forever: the dialog may be
    # dismissed, or there may be no UI to show it in.
    while ! command_line_tools_installed; do
        if [ "$waited" -ge 3600 ]; then
            echo 'ERROR: Command Line Tools still not installed after 60 minutes.' >&2
            echo '       Install them manually, then re-run this script.' >&2
            return 1
        fi
        sleep 15
        waited=$((waited + 15))
    done
}

command_line_tools_installed() {
    pkgutil --pkg-info=com.apple.pkg.CLTools_Executables >/dev/null 2>&1
}

# Can this process put a window on the screen? NOTE: Avoid asking System
# Events, because on a fresh Mac that raises a TCC automation prompt —
# an interactive dialog in the middle of deciding whether we should be interactive.
gui_session_available() {
    # A remote shell cannot show a dialog, even when someone is logged in at the
    # machine's own screen.
    [ -z "${SSH_CONNECTION:-}" ] || return 1
    # /dev/console belongs to whoever is logged in at the login window.
    [ "$(stat -f%Su /dev/console 2>/dev/null)" = "$(id -un)" ]
}

install_command_line_tools
