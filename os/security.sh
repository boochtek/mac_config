#!/bin/bash

# Variant of the unofficial Bash strict mode.
set -uo pipefail
IFS=$'\n\t'
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR
[[ -n "${DEBUG+unset}" ]] && set -x


# Per https://github.com/termstandard/colors:
# TODO: Add COLORTERM to SendEnv list in /etc/ssh/ssh_config.
# TODO: Add COLORTERM to AcceptEnv list in /etc/ssh/sshd_config.
# TODO: Add COLORTERM to env_keep list in /etc/sudoers.
# TODO: Add these to private_confif, server_config, openwrt_config.
