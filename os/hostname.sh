#!/bin/bash

## Mac OS X has several places where the hostname is stored. This updates all of them.

SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get desired host name. TODO: Replace `inventory_for_mac_serial_number.sh` with something simpler.
hostname="$($SCRIPT_DIR/../inventory_for_mac_serial_number.sh | grep 'mac' | awk '{print $3}' | tr -d '\"' )"
echo "Desired hostname: $hostname"

if [[ "$hostname" == '' ]]; then
    exit 1
fi

# Set host name, if necessary.
if [[ ! "$hostname" == "$(hostname)" ]]; then
    echo "Setting host name: $hostname"
    sudo scutil --set HostName "$hostname"
fi

# Set computer name, if necessary.
if [[ ! "$hostname" == "$(/usr/sbin/networksetup -getcomputername)" ]]; then
    echo "Setting computer name: $hostname"
    sudo /usr/sbin/networksetup -setcomputername "$hostname"
fi

# Set local name, if necessary.
if [[ ! "$hostname" == "$(sudo /usr/sbin/systemsetup -getlocalsubnetname | cut -b 20-)" ]]; then
    echo "Setting local name: $hostname"
    sudo /usr/sbin/systemsetup -setlocalsubnetname "$hostname"
fi


# IP0=$(/sbin/ifconfig en0 | grep 'inet ' | awk '{ print $2 }')
# COMPUTERNAME=$(host "$IP0" | awk '{ print $5 }' | awk -F. '{ print $1 }')
# LOCALHOSTNAME=$(host "$IP0" | awk '{ print $5 }' | awk -F. '{ print $1 }')

# ### Computer Name: $COMPUTERNAME
# if [ ! "$(/usr/sbin/networksetup -getcomputername)" = "$COMPUTERNAME" ]; then
#   sudo /usr/sbin/networksetup -setcomputername $COMPUTERNAME
# fi

# ### Local Hostname: $LOCALHOSTNAME
# if [ ! "$(/usr/sbin/systemsetup -getlocalsubnetname)" = "Local Subnet Name: $LOCALHOSTNAME" ]; then
#   sudo /usr/sbin/systemsetup -setlocalsubnetname $LOCALHOSTNAME > /dev/null 2>&1
# fi
