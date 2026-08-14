---
name: test-mac-setup-vm
description: Run the mac-setup scripts in a disposable macOS VM and iterate on failures. Use when testing the setup suite against a fresh macOS (a new Mac, or an OS upgrade) via the test/ harness.
---

# Testing mac-setup in a VM

Run the setup suite against a throwaway VM clone and fix what breaks. Full design
is in `docs/vm-test-harness-prd.md`; the harness itself is in `test/`.

## Prerequisites (one-time)

Full walkthrough in `test/README.md`. In short: `make setup` (installs `tart`) →
`make image` → `make boot` → click through Setup Assistant and enable Remote
Login → `make access` → `make freeze`.

Two host-side gotchas that produce confusing failures:

- **`VM_USER`** defaults to the host's login name (`id -un`). If the VM's admin
  account differs, every target needs `VM_USER=<name>` — otherwise SSH fails as
  the wrong user.
- **Local Network permission** (macOS 15+): a terminal app that was denied it
  can't reach the VM's private IP, and everything fails with a misleading
  `No route to host`. `test/setup-access.sh` pre-flights this (ping + port 22)
  and prints which of the two causes it is. Fix in System Settings → Privacy &
  Security → Local Network; quit and reopen System Settings if the app isn't
  listed. `tccutil` cannot reset it.

## Run

```sh
make test                        # full suite, watchable window
RUN_GROUPS='os shell' make test  # a subset, for fast iteration
make test KEEP=true              # keep the clone to inspect it
make test HEADLESS=true          # no VM window
```

Flags accept any spelling — only `false`, `no`, `off`, `0`, and empty are false
(case-insensitive); anything else is true. Output streams to
`test/logs/<run>.log`.

Watch a run in progress with `make follow-logs` (tails the log) and `make ssh`
(shell into the running clone). The Command Line Tools download (~1 GB) prints
nothing for minutes and looks like a hang; confirm it is alive with
`tail -f /var/log/install.log | grep -E 'Starting download|Verifying'` — not by
watching `/Library/Updates`, which stays unchanged until packages finish.

Other targets worth knowing (`make help` lists all): `make clone NEW=<name>
[FROM=<image>]` duplicates an image — use it before an OS upgrade so the
pre-upgrade version survives; `make clean` deletes leftover run clones;
`make clean-cache` frees tart's cached IPSWs (~20 GB each); `make list-vms` lists VMs.
Images run ~20 GB apiece, so watch disk space with `df -h ~` (not Finder).

## Iterate on failures

1. Read the newest `test/logs/*.log`.
2. Locate each failure. The strict-mode ERR trap prints
   `<script>: Error on line <N>: <command>` — that pinpoints script and line.
3. Classify each:
   - **Expected App-Store gap** (`mas`, or `open -a` on an uninstalled Store
     app) → leave it; a VM can't install Store apps.
   - **Real bug** (unset variable under `set -u`, missing dependency, wrong
     path, non-idempotent step) → fix the script on the host working tree.
   - **Headless/interactive blocker** (a GUI prompt, `xcode-select --install`,
     a `sudo` password prompt) → make the step VM-safe (non-interactive flag,
     guard) or document why it needs a human.
   - **Nothing ran at all** — a `(WARNING: init.sh left the shell in …)` line,
     or every group reporting `(SKIP: … does not exist)` → something sourced by
     `init.sh` changed the working directory. The run will still look like it
     succeeded. Only `work/ALL.sh` is legitimately absent.
   - **Stalled with no output** → usually a real App-Store command that reached
     the network instead of the shim. Every shimmed call should log
     `[mas-shim] skipped in VM: …`; if real `mas` output appears instead,
     something re-ordered `PATH` ahead of `~/bin` after `run.sh` set it.
4. Re-run — `run.sh` rsyncs the working tree, so host edits take effect on the
   next clone. Clones are disposable; no state carries over.
5. Repeat until the only remaining failures are the expected App-Store gaps.

## Notes

- Never fake a pass. An App-Store step that can't run is reported as skipped, not
  green.
- Prefer fixing the real scripts over the harness — a passing VM run is only
  meaningful because the tested path matches the real path.
- For a stuck clone: `make test KEEP=true`, then
  `ssh -i ~/.ssh/mac-setup-vm "$VM_USER@$(test/lib/vm-ip <run>)"` to poke around.
  Use `test/lib/vm-ip`, not `tart ip` — the latter fails to resolve VMs on
  macOS 26.
- Runs are host-driven: an AI agent's sandbox usually can't reach the VM subnet,
  so the human runs `make test` and the agent reads `test/logs/`.
