#!/bin/bash

# Run the setup suite against a fresh, disposable clone of the VM image and
# capture the output. The image is never mutated; each run gets its own clone.
#
# Usage (flags accept true/1/yes/on):
#   ./test/run.sh                          # full suite in a watchable VM window
#   RUN_GROUPS='os shell' ./test/run.sh    # only os/ALL.sh and shell/ALL.sh
#   KEEP=true ./test/run.sh                # keep the clone afterward, to inspect
#   HEADLESS=true ./test/run.sh            # no VM window

set -Euo pipefail
IFS=$'\n\t'
[[ -n "${DEBUG+unset}" ]] && set -x
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" >&2 ; exit $RC' ERR

IMAGE="${IMAGE:-mac-setup-$(sw_vers -productVersion)}"
VM_USER="${VM_USER:-$(id -un)}"
SSH_KEY="${SSH_KEY:-$HOME/.ssh/mac-setup-vm}"
REPO="$(cd "$(dirname "$0")/.." && pwd)"
RUN="mac-setup-run-$(date '+%Y%m%d-%H%M%S')"
LOG_DIR="$REPO/test/logs"
LOG="$LOG_DIR/$RUN.log"

# Which ALL.sh groups to run, in README order. Override with
# RUN_GROUPS='os shell'. NOT named GROUPS: bash auto-populates that with the
# user's group IDs, so "${GROUPS:-default}" silently yields a gid, not the default.
RUN_GROUPS="${RUN_GROUPS:-os hardware shell web editors dev email work misc personal}"

# Boolean flags: only the explicit "off" spellings are false, so a typo errs
# toward the value the caller obviously meant rather than silently ignoring it.
is_true() {
    case "$(printf '%s' "${1:-}" | tr '[:upper:]' '[:lower:]')" in
    '' | 0 | false | no | off) return 1 ;;
    *) return 0 ;;
    esac
}

mkdir -p "$LOG_DIR"

ssh_opts=(-i "$SSH_KEY" -o BatchMode=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR)
# Host-side expansion of the command is intentional: the caller builds the
# remote script here and the VM receives the literal text.
# shellcheck disable=SC2029
vm_ssh() { ssh "${ssh_opts[@]}" "$VM_USER@$IP" "$@"; }

cleanup() {
    if is_true "${KEEP:-}"; then
        echo "KEEP — leaving clone '$RUN' running for inspection (test/lib/vm-ip $RUN)."
    else
        tart delete "$RUN" || true
    fi
}
trap cleanup EXIT

echo "Cloning $IMAGE -> $RUN"
tart clone "$IMAGE" "$RUN"

echo "Booting $RUN"
if is_true "${HEADLESS:-}"; then
    tart run --no-graphics "$RUN" &
else
    tart run "$RUN" &
fi

echo "Waiting for VM IP..."
IP=""
for _ in $(seq 1 90); do
    # Only accept something shaped like an IPv4 address: a helper that printed a
    # diagnostic instead of a value must not be mistaken for one.
    IP="$("$REPO/test/lib/vm-ip" "$RUN" || true)"
    [[ "$IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] && break
    IP=""
    sleep 2
done
[[ -z "$IP" ]] && {
    echo "ERROR: VM never reported an IP address."
    exit 1
}
echo "VM IP: $IP"

# Wait for SSH to answer.
for _ in $(seq 1 60); do
    vm_ssh true && break
    sleep 2
done

echo "Delivering working tree to VM:~/mac-setup ..."
rsync -a --delete \
    --exclude '.git' --exclude 'test/logs' \
    -e "ssh ${ssh_opts[*]}" \
    "$REPO/" "$VM_USER@$IP:mac-setup/"

echo "Installing mas shim and VM ENV.sh ..."
vm_ssh 'mkdir -p ~/bin'
scp "${ssh_opts[@]}" "$REPO/test/lib/mas" "$VM_USER@$IP:bin/mas"
vm_ssh 'chmod +x ~/bin/mas'
scp "${ssh_opts[@]}" "$REPO/test/vm-env.sh" "$VM_USER@$IP:mac-setup/ENV.sh"

echo "Running suite (log: $LOG)"
# ~/bin (mas shim) must precede Homebrew on PATH. init.sh is sourced; each
# ALL.sh group runs in order. NONINTERACTIVE lets Homebrew install unattended.
{
    echo "===== run $RUN @ $(date) ====="
    vm_ssh "export PATH=\$HOME/bin:\$PATH NONINTERACTIVE=1
        cd ~/mac-setup || exit 1
        SETUP_DIR=\"\$PWD\"
        echo '----- init.sh -----'
        source ./init.sh
        # init.sh is sourced, so a 'cd' inside it would redirect the whole run.
        # Keep group lookups absolute and run each from \$SETUP_DIR.
        [ \"\$PWD\" = \"\$SETUP_DIR\" ] || echo \"(WARNING: init.sh left the shell in \$PWD)\"
        for g in $RUN_GROUPS; do
            echo \"----- \$g/ALL.sh -----\"
            if [ ! -f \"\$SETUP_DIR/\$g/ALL.sh\" ]; then
                echo \"(SKIP: \$g/ALL.sh does not exist)\"
            elif [ ! -x \"\$SETUP_DIR/\$g/ALL.sh\" ]; then
                echo \"(SKIP: \$g/ALL.sh is not executable)\"
            else
                (cd \"\$SETUP_DIR\" && \"./\$g/ALL.sh\") ; echo \"(\$g/ALL.sh exited \$?)\"
            fi
        done"
} 2>&1 | tee "$LOG"

echo "Done. Log saved to $LOG"
