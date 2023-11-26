#!/bin/bash

set -euo pipefail; IFS=$'\n\t'

# This adds the `ip` command. Note that it's incomplete, compared to the Linux version.
#   `ip address`
#   `ip route`
# NOTE: This port does not include the `ss` (socket statistics) command.
brew install --quiet iproute2mac

# Netcat is useful for testing and using TCP ports.
brew install --quiet netcat

# NOTE: The `netstat` that comes with MacOS is more limited than the Linux variant.
# Use `lsof -sTCP:LISTEN -iTCP -nP` as the equivalent of `netstat -plant`
# Or `netstat -p tcp -van | grep '^Proto\|LISTEN'`
# TODO: Make a shell function to handle these differences.

# Telnet client only, for troubleshooting network services.
brew install --quiet telnet

# NcFTP and LFTP provide some useful features (bookmarks, resume, mirroring) that other FTP clients don't.
brew install --quiet ncftp
brew install --quiet lftp

# NMap is a network tool for port scanning, network mapping, remote OS detection, firewall detection, and more.
brew install --quiet nmap

# Iftop shows network usage, similar to how `top` shows CPU usage.
brew install iftop
sudo chown root:wheel "$HOMEBREW_PREFIX"/Cellar/iftop/*/sbin/iftop
sudo chmod u+s "$HOMEBREW_PREFIX"/Cellar/iftop/*/sbin/iftop

# Rsnapshot uses rsync to take snapshots of file systems to make remote incremental backups.
brew install --quiet rsnapshot

# Tcpflow is like tcpdump, but shows TCP-layer streams instead of packets.
brew install --quiet tcpflow

# Ngrep is like a combination of tcpdump and grep.
brew install --quiet ngrep
