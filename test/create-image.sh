#!/bin/bash

# Build the pristine VM image that test runs clone from. ONE-TIME.
#
# This script only does the fully-automatable part: downloading the IPSW and
# installing macOS onto a fresh VM disk. The remaining first-boot steps (Setup
# Assistant, enabling SSH, injecting the automation key, passwordless sudo) are
# assisted/manual and documented below — see test/README.md for the "why".

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" >&2 ; exit $RC' ERR

IMAGE="${IMAGE:-mac-setup-$(sw_vers -productVersion)}"
DISK_GB="${DISK_GB:-80}"

# Which macOS to install. Defaults to the newest Apple publishes for the VM
# device, while IMAGE above is named for THIS Mac's version — they agree as long
# as this Mac is up to date. If Apple has since shipped a newer release, either
# pin IPSW to a matching restore image or pass a matching IMAGE name, so the
# image's name doesn't misreport what's inside it. Pin like this:
#   IPSW='https://updates.cdn-apple.com/.../UniversalMac_26.6_25G72_Restore.ipsw'
IPSW="${IPSW:-latest}"

if tart list | grep -q "[[:space:]]${IMAGE}$"; then
    echo "VM '${IMAGE}' already exists — skipping create."
else
    # ASIF disk format is sparse + fast; requires a macOS 26 Tahoe host.
    tart create "$IMAGE" --from-ipsw="$IPSW" --disk-size "$DISK_GB" --disk-format asif
fi

cat <<NEXT

The VM image disk is built. Remaining ONE-TIME steps (see test/README.md):
  1. make boot                                 # open the VM window
  2. Click through Setup Assistant yourself — create an admin account named to
     match your Mac's login (or pass VM_USER=<name> later) and set a password.
     Do it manually (scripted typing is unreliable, and you must be present for
     the password regardless).
  3. In the VM: System Settings > General > Sharing > enable Remote Login.
  4. From YOUR terminal (not the VM): make access
     Installs the automation SSH key + passwordless sudo; prompts for the VM
     password (which the AI never sees). Avoids the flaky host->guest clipboard.
  5. make freeze                               # shut down + freeze the image

After that, 'make test' clones the image and runs the suite.
NEXT
