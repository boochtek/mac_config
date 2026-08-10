#! /bin/bash

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" >&2 ; exit $RC' ERR

# Cache the sudo password.
echo "$(tput setaf 4)You may be prompted for your sudo password.$(tput sgr0)"
# Pre-authorize sudo. Skip the prompt when sudo is already passwordless, so
# unattended runs (such as the VM test harness over SSH) do not fail here.
sudo -n true 2>/dev/null || sudo -v

# Siege is an HTTP load testing and benchmarking tool.
brew install --quiet siege

# WGet is similar to Curl, but has some different options.
brew install --quiet wget

# HTTPie is like cURL, but better for working with APIs.
# NOTE: HTTPie also has a GUI front-end, available as a cask.
brew install --quiet httpie

# Curlie is like HTTPie, using Curl as backend.
brew install --quiet curlie

# XH is another modern replacement for HTTPie.
brew install --quiet xh

# Convert from HTML to Markdown. See https://html-to-markdown.com/.
# TODO: Also consider [Breakdance](https://breakdance.github.io/breakdance/docs.html).
brew install --quiet html2markdown
