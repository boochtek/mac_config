#!/bin/bash -e


# Returns the hostname and groups for the local (Mac) system, based on hardware serial number.
# Used as a dynamic inventory script for Ansible.
# See http://docs.ansible.com/ansible/developing_inventory.html for details.


# TODO:
#   * Return an empty hash if given --host
#   * Error out on anything other than --host or --list or --all
#   * Move configuration to an external file.


# Mappings of serial numbers to hostname and groups.
# You can find your serial number in 'About This Mac'.
# Or you can run `ioreg -l | grep IOPlatformSerialNumber` from the command line.
# The groups correspond to roles (subdirectories in the `roles` directory).
HOST_MAPPINGS="
C02JG2RXDKQ4  hope      mac workstation dev
C02TH22UGTDY  FLD-ML-00021621       mac workstation dev f5
C02XX2Z3JG5M  WM00219-ENG-CBuchek   mac workstation dev weedmaps
"


function main() {
    local hostname="$(hostname)"
    local groups="$(groups_for_host $hostname)"
    echo "$(list_json $hostname "$groups")"
}


function hostname() {
  local hostname=""

  hostname="$(hostname_for_serial_number)"
  [[ ! -z "$hostname" ]] && echo $hostname && return 0

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


function serial_number() {
    ioreg -c IOPlatformExpertDevice -d 2 | awk '/IOPlatformSerialNumber/ { print $3; }' | tr -d '"'
}


function hostname_for_serial_number() {
    grep "^$(serial_number)" <<<"$HOST_MAPPINGS" | awk '{print $2}'
}


main
