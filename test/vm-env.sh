# VM test ENV — copied over ENV.sh inside the guest by test/run.sh.
#
# Unlike the real ENV.sh, this sets SYSTEM_SERIAL_NUMBER to the VM's *own*
# serial (read at runtime), so the machine-guard passes exactly as designed —
# the same per-machine customization a human does when adopting the repo, not a
# bypass. No hard exit gate here: a test VM is not the primary Mac.

# shellcheck shell=bash

SYSTEM_SERIAL_NUMBER="$(system_profiler SPHardwareDataType | awk -F ': ' '/Serial Number/ {print $2}')"
export SYSTEM_SERIAL_NUMBER

export SYSTEM_NAME='Mac Setup Test VM'
export HOSTNAME='mac-setup-test'

# Extra groups to install (match the real ENV.sh default).
export INSTALL_GROUPS='mac workstation dev'

# Config files repo (HTTPS, since the VM has no SSH key for GitHub).
export CONFIG_FILES_URL='https://github.com/booch/config_files.git'
export CONFIG_FILES_BRANCH='master'

# Hardware flags: a Virtualization.framework guest is Apple Silicon, no Touch
# Bar / Touch ID.
export HAS_TOUCH_ID=0
export HAS_TOUCH_BAR=0
export HAS_APPLE_SILICON=1
export HAS_INTEL_CPU=0
