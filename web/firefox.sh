#!/bin/bash

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR

## Configure Firefox via Enterprise Policies: extensions and preferences.
## Writes policies.json into each installed Firefox app bundle.
## Idempotent: re-running copies the same policies file.
## Assumes 1Password desktop app is already installed (its browser integration auto-connects).
## NOTE: Requires sudo to write into the app bundles.
## NOTE: Re-run after Firefox updates — Homebrew reinstalls the app bundle and clears distribution/.

source "${BASH_SOURCE%/*}/../util/colors.sh"

SCRIPT_DIR="$(cd "${BASH_SOURCE%/*}" && pwd)"

install_policies() {
	local app_path="$1"
	local dist_dir="${app_path}/Contents/Resources/distribution"

	if [[ ! -d "${app_path}" ]]; then
		return
	fi

	sudo mkdir -p "${dist_dir}"
	sudo cp "${SCRIPT_DIR}/firefox-policies.json" "${dist_dir}/policies.json"
	echo "Wrote ${dist_dir}/policies.json"
}

install_policies "/Applications/Firefox.app"
install_policies "/Applications/Firefox Developer Edition.app"

echo ""
echo "${BOLD}Manual steps required after restarting Firefox:${RESET}"
echo "${BLUE}  * Restart Firefox to apply the policies and trigger extension installs.${RESET}"
echo "${BLUE}  * Sign in to 1Password (auto-connects to the desktop app after sign-in).${RESET}"
echo "${BLUE}  * Configure Raindrop.io, Stylus, Tab Session Manager, etc. on first run.${RESET}"
echo "${YELLOW}  * Video DownloadHelper: install the companion app for non-mp4 formats:${RESET}"
echo "${YELLOW}      https://www.downloadhelper.net/install-coapp.php${RESET}"
