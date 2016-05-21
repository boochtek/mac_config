#!/bin/bash -e


# Returns the hostname and groups for the local (Mac) system, based on MAC address.
# Used as a dynamic inventory script for Ansible.
# See http://docs.ansible.com/ansible/developing_inventory.html for details.


# TODO:
#   * Return an empty hash if given --host
#   * Error out on anything other than --host or --list or --all
#   * Move configuration to an external file.


# Mappings of MAC address to hostname and groups.
HOST_MAPPINGS="
a0:99:9b:00:00:00  hope      mac workstation dev mercy
a0:99:9b:03:8d:9b  colbert   mac workstation dev centurylink
"


function main() {
    local hostname=$(hostname)
    local groups="$(groups_for_host $hostname)"
    echo "$(list_json $hostname "$groups")"
}


function hostname() {
  local hostname=""

  for mac_address in "$(mac_addresses)" ; do
      hostname="$(hostname_for_mac_address $mac_address)"
      [[ ! -z $hostname ]] && echo $hostname && return 0
  done

  return 1
}


function groups_for_host() {
    local hostname=$1
    grep $hostname <<<"$HOST_MAPPINGS" | awk '{$1 = ""; $2 = ""; print $0}'
}


function list_json() {
    local hostname=$1
    local groups="$2"
    local first_group=0

    echo "{"
    for group in $groups ; do
        if [[ $first_group -eq 0 ]]; then
            first_group=1
        else
            echo ","
        fi
        echo "  \"$group\": [ \"$hostname\" ]"
    done
    echo "}"
}


function mac_addresses() {
    ifconfig | grep -E "^\s+ether\s+([0-9a-f]{2}:){5}([0-9a-f]{2})" | awk '{print $2}'
}


function hostname_for_mac_address() {
    local mac_address=$1
    grep $mac_address <<<"$HOST_MAPPINGS" | awk '{print $2}'
}


main
