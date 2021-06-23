#!/bin/bash

## Mac OS X has several places where the hostname is stored. This updates all of them.

# Get desired host name. TODO: Replace `inventory_for_mac_serial_number.sh` with something simpler.
hostname="$(./inventory_for_mac_serial_number.sh | grep 'mac' | )"
echo "Desired hostname: $hostname"

# Set host name, if necessary.
if [[ ! "$hostname" == "$(hostname)" ]]; then
    echo "Setting host name: $hostname"
    #sudo scutil --set HostName "$hostname"
fi

# Set computer name, if necessary.
if [[ ! "$hostname" == "$(/usr/sbin/networksetup -getcomputername)" ]]; then
    echo "Setting computer name: $hostname"
    #sudo /usr/sbin/networksetup -setcomputername "$hostname"
fi

# Set local name, if necessary.
if [[ ! "$hostname" == "$(sudo /usr/sbin/systemsetup -getlocalsubnetname | cut -b 20-)" ]]; then
    echo "Setting local name: $hostname"
    #sudo /usr/sbin/systemsetup -setlocalsubnetname "$hostname"
fi
