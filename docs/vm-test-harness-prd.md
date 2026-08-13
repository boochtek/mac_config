# PRD: macOS VM Test Harness for the Setup Scripts

- **Status:** Approved (design) — pending implementation plan
- **Date:** 2026-07-14
- **Owner:** repo maintainer
- **Related:** [TODO.md](../TODO.md) → "TESTING: Spin up a new MacOS VM to test the full scripted setup"

## 1. Summary

Build a repeatable harness that runs this repository's setup scripts inside a
disposable macOS virtual machine, so we can verify a fresh-Mac setup end-to-end
before it matters on real hardware. The harness is **scripted** (an AI or a
human can drive it over SSH and read results) yet **watchable** (a live GUI
window shows OS-preference and app-configuration changes taking effect).

## 2. Problem & Motivation

The setup scripts have accreted over many years, and are only ever exercised on
the maintainer's own Macs — infrequently. There is no safe way to answer:

- Does a clean, ordered run still work on a pristine macOS install?
- Will the scripts survive the next OS upgrade *before* committing to that upgrade on real hardware?
- Which steps have silently rotted, or now require manual intervention?

A disposable VM makes these low-consequence and repeatable. It also lets an AI
agent iterate: run → read failures → fix a script → reset → re-run.

## 3. Goals

- Run the suite against a **pristine** macOS VM.
- Reset to a clean state between runs in seconds, so iteration is cheap.
- Drive runs over SSH and capture full logs on the host for inspection.
- Provide live GUI window for manual visual verification of GUI apps and preferences.
- Keep tested execution path identical to real path, so a passing VM run is meaningful.
- Test against a **clean install from an Apple IPSW**, for highest fidelity for
  new Mac and OS-upgrade scenarios.

## 4. Non-Goals

- Testing anything that requires Apple ID authentication — Mac App Store (`mas`)
  installs and iCloud sign-in are **impossible** in an Apple Virtualization
  guest and are explicitly out of scope. These steps are *skipped and reported
  as skipped*, never faked.
- Testing hardware-specific behavior with no VM equivalent (Touch Bar, external displays, etc).
- A CI service / scheduled automation. This is a local, on-demand harness.

## 5. Constraints & Environment

- **Host:** Apple Silicon (arm64), macOS (currently 26.x Tahoe).
    - Apple Silicon can only virtualize macOS-on-macOS, which is exactly the target.
    - No need for Intel support.
- **Framework reality:** every viable tool (tart, UTM, VirtualOS) sits on
  Apple's Virtualization.framework, so raw guest capability is identical across
  them; they differ only in automation and reset ergonomics.
- **No App Store / iCloud in guests** (Apple restriction).
- **Disposable VMs** — each test run happens on a throwaway clone, so residual
  mess (failed `open -a`, dangling login items) is inconsequential.

## 6. Tooling Decision: `tart`

**Chosen: [`tart`](https://tart.run)** (Cirrus Labs), installed via Homebrew.

Rationale (vs. UTM and VirtualOS, all on the same framework):

| Capability | tart | UTM | VirtualOS |
|---|---|---|---|
| Clean install from IPSW | ✅ `tart create --from-ipsw` | ✅ (GUI) | ✅ (GUI) |
| Watchable window | ✅ `tart run` | ✅ | ✅ |
| CLI / headless automation | ✅ first-class | ⚠️ `utmctl` bolt-on | ❌ |
| SSH-driven from host | ✅ via `tart ip` | ✅ (after enabling) | ⚠️ DIY |
| **Reset to clean per run** | ✅ instant CoW `clone` | ❌ no macOS-guest snapshots | ❌ manual |
| Repo into VM | ✅ `--dir` virtiofs | ⚠️ fiddlier | ⚠️ manual |
| Cost | Free (personal) | Free/OSS | Free/OSS |

The deciding factor is **reset**. The workflow is *clone the pristine golden image → run →
inspect → discard clone → repeat*. tart's copy-on-write clones make that instant
and near-free on APFS. UTM **cannot snapshot macOS guests** (an Apple-backend
limitation), so every reset is a full-disk copy or a manual re-run on a
dirtying VM. VirtualOS has no automation surface at all.

**Accepted tradeoff:** tart has no in-place "revert to snapshot"; reset is done
by re-cloning the immutable golden image. This is cleaner (immutable base, disposable
clones) but differs from Parallels/VMware snapshot model.

## 7. Manual GUI Inspection

tart is CLI-*first*, not CLI-*only*:

- `tart run <vm>` opens a native window with full keyboard/mouse — click through
  System Settings, open apps, verify preference panes and login items.
- The GUI window and SSH are independent channels into the **same** running VM,
  so the harness can drive `web/firefox.sh` over SSH while the window shows
  Firefox being configured live.
- For higher fidelity or remote viewing: enable Screen Sharing in the guest and
  connect to `tart ip`, or use tart's `--vnc` endpoint even in headless runs.

## 8. Repo-Integration Approach: Phased

The two points of friction are the serial-number gate and the four `mas`
scripts. The harness is delivered in two phases:

- **Phase 1 — external overrides, zero script edits:** ship fast by
  neutralizing the friction from *outside* the setup scripts, so testing can
  start immediately.
- **Phase 2 — VM-aware scripts:** as the repo-wide strict-mode PR
  lands, migrate the neutralization *into* the scripts as a first-class,
  committed `util/vm.sh` concept — see §8.3.

### 8.0 Strict-mode & formatting context

The setup scripts follow a custom strict-mode header — `set -Euo pipefail`,
`IFS=$'\n\t'`, a `DEBUG=1` `set -x` trace toggle, and a `trap … ERR` handler that
reports the failing script/line/command and exits — codified in the `lang-bash`
skill. There is deliberately **no `-e`**: the ERR trap is the fail-fast
mechanism, giving informative errors that `-e` would not, and `-E` (`errtrace`,
Bash 3.0+) makes that trap fire inside functions and subshells too — the one
place a bare trap is weaker than `-e`. A repo `.editorconfig` keeps `shfmt`
aligned with the repo's convention.

### 8.1 Serial-number gate — solved by intended usage, not a hack

[ENV.sh:11-16](../ENV.sh) aborts unless the machine's serial matches a hardcoded
value. The harness supplies a VM-specific `ENV.sh` whose `SYSTEM_SERIAL_NUMBER`
is the VM's serial number (read via `system_profiler` inside the guest). The
gate then passes exactly as designed — this is the same per-machine
customization a human does when adopting the repo, not a bypass.

The VM `ENV.sh` also sets: a VM hostname/`SYSTEM_NAME`, `INSTALL_GROUPS`, and the
`CONFIG_FILES_URL`. The `HAS_*` hardware flags already auto-detect and will
resolve correctly for the VM (arm64 ⇒ `HAS_APPLE_SILICON=1`, no Touch Bar, etc).

### 8.2 The four `mas` scripts — neutralized by a PATH shim

The only scripts that cannot run in a VM are the three that call `mas`:

- [os/app_store.sh](../os/app_store.sh) — Bear, Firetask
- [os/virtualization.sh](../os/virtualization.sh) — VirtualOS
- [os/1password.sh](../os/1password.sh) — 1Password for Safari (the app and CLI
  come from Homebrew, so those *are* tested)

Only those four App Store installs go untested — plus `mas upgrade` and the
login-item registration for them. Everything else in the same scripts (Homebrew
installs, `defaults` writes, dock changes) runs normally. Expect one visible
side effect: with an app absent, the following `open -a <App>` fails and the
script's ERR trap exits it there (in `app_store.sh` that skips the remainder of
the file). Report these as App-Store gaps, never as passes.

The harness places a **no-op `mas` shim** in a directory *prepended* to `PATH`,
so every `mas` call returns success. That is what keeps the run going:
without it, a failed `mas` would trip our `trap … ERR` handler and print errors.
With the shim, nothing downstream trips. Because the VM is disposable, any
residual effects (a failed `open -a <App>`, a dangling login item, etc) vanish
when the clone is deleted.

**Known cost of Phase 1:** the "mas is neutralized in VMs" knowledge lives only
in the harness, invisible to a reader of the setup scripts. Phase 2 (§8.3)
removes this cost by making the scripts VM-aware.

### 8.3 Phase 2 — VM-aware scripts

Once the strict-mode PR is touching every script anyway, "don't edit the scripts"
advantage disappears, so the neutralization migrates into a small, committed shared layer:

- **`util/vm.sh`** — a `running_in_vm` detector plus `skip_if_vm "reason"`, used
  at the top of the four `mas` scripts to early-return with an honest, logged
  reason instead of relying on an external shim.
- **`manual_step "…"`** (in `util/`, built on [util/colors.sh](../util/colors.sh))
  — announces any step needing human action (a GUI toggle, a sign-in, a hardware
  step) in bold **yellow**, in a consistent, greppable form:

  ~~~ bash
  manual_step() { printf '%s%s⚠ MANUAL STEP:%s %s\n' "$BOLD" "$YELLOW" "$RESET" "$*"; }
  ~~~

  This serves double duty: guidance for a human on real hardware, **and** a
  machine-detectable marker so an unattended harness run can flag or skip a step
  instead of blocking on an interactive prompt. (The image's passwordless
  `sudo` already prevents the most common hang; `manual_step` covers the rest.)

Phase 2 turns "is this the primary machine / can this run unattended?" into a
reusable, tested concept rather than external scaffolding.

## 9. Architecture

Three layers, all outside the setup scripts:

``` tree
Host (macOS Tahoe, Apple Silicon)
├── tart                     # VM lifecycle: create / clone / run / ip / delete
├── VM image   (pristine)    # built once from IPSW; never mutated
├── test/  (new harness dir)
│   ├── host driver          # orchestrates a run: clone → boot → ssh → run → log → teardown
│   ├── vm ENV.sh (generated)# real VM serial + VM settings (§8.1)
│   ├── mas shim             # no-op, prepended to PATH in the guest (§8.2)
│   └── logs/                # captured per-run output on the host
└── run-N VM  (disposable)   # CoW clone of the golden image, one per iteration
```

### Data flow

1. Host clones the image → `run-N` (instant, CoW).
2. Host boots `run-N` with `tart run` (window visible) and a `--dir` mount of
   the working tree, or delivers the repo via `git clone` / `rsync`.
3. Host drops the generated VM `ENV.sh` and the `mas` shim into place inside the
   guest, then SSHes in and executes the chosen scripts.
4. Guest stdout/stderr streams back over SSH to `test/logs/` on the host.
5. Host (human or AI) reads logs, edits scripts on the host, deletes `run-N`,
   and repeats from step 1.

The **golden image is immutable**; all mutation happens on throwaway clones.

## 10. Workflow

### 10.1 One-time image creation (has manual steps)

Every step is a `make` target; the underlying `tart` commands are an
implementation detail of `test/`.

1. `make setup` — installs `tart` (trusting the `cirruslabs/cli` tap).
2. `make image` — downloads Apple's ~20 GB restore image and installs macOS onto
   an ~80 GB VM disk.
3. `make boot`, then complete **Setup Assistant manually once** — create a local
   admin account (no Apple ID needed), skip iCloud.
4. Inside the guest, enable Remote Login. On the host, grant the terminal app
   Local Network permission (macOS 15+), or every connection to the VM fails with
   a misleading "No route to host".
5. `make access` — installs the automation SSH key and passwordless `sudo`.
6. `make freeze`. This VM is now the pristine golden image; never run tests on it
   directly.

### 10.2 Per-run cycle (fully scripted)

`make test` drives all of this; the commands below are what `test/run.sh` does
internally.

``` shell
tart clone <image> run-N
tart run --dir=repo:<worktree>:ro run-N   # window opens; watchable
scp  test/ENV.vm.sh  test/mas-shim/mas  admin@$(tart ip run-N):~/   # writable, outside the RO mount
ssh  admin@$(tart ip run-N) '<runner: place ENV.sh + shim, prepend shim to PATH, run scripts>'
# → logs stream to test/logs/run-N.log
tart delete run-N                         # discard
```

The repo mount is read-only (for testing WIP), so the generated `ENV.sh` and the
`mas` shim are pushed separately over SSH into a writable location in the guest
home — see the open question in §15.

### 10.3 Testing a macOS upgrade

To vet an OS update before applying it to real hardware: `make clone NEW=<next>`
to retain the pre-upgrade version, `make boot`, run **Software Update** inside
the VM, `make freeze`, then `make test`.
The `IMAGE` variable keeps versioned images side by side — e.g.
`IMAGE=mac-setup-27b2 make boot|freeze|test` — so each OS version has its own
frozen image, and comparing or rolling back is just a name change. This is the
lower-consequence beta-testing path from [TODO.md](../TODO.md).

## 11. Scope of Scripts

- **Run:** `init.sh`, then each of the `ALL.sh` scripts, in the order in the README.
    - When you run into an issue, you can run individial scripts
        - to target the issue
        - to save time and tokens
- **Neutralized:** the four `mas` scripts in §8.2 are skipped, but their
  non-`mas` side effects (eg. `defaults` writes, dock changes) still execute.
- **Reported as skipped:** any step the harness explicitly declines to run.

## 12. Known Gotchas & Error Handling

- [os/network.sh](../os/network.sh) manipulates network hardware; it may misbehave
  on a VM's virtual NIC. It now carries the full strict-mode header (`set -Euo
  pipefail` + `trap … ERR`), so a failed command **fails fast** with a diagnostic
  rather than continuing — watch its output on the first run.
- `set -u` scripts (e.g. `clipboard.sh`) will abort on any undefined variable —
  the generated VM `ENV.sh` must define everything the suite references.
- Interactive prompts hang unattended runs. Passwordless `sudo` in the image
  covers `sudo`; any other human-required step must be wrapped in `manual_step`
  (Phase 2, §8.3) so the harness can detect and flag rather than block.
    - First real instance, found by the first run: `xcode-select --install` asks
      the window server for a dialog, so over SSH it fails and the old polling
      loop in [init/command-line-tools.sh](../init/command-line-tools.sh) spun
      forever. It now picks an installer to match the session: a harness run
      installs headlessly via `softwareupdate`, while someone at the keyboard
      still gets Apple's dialog, each falling back to the other. The headless
      path is retried three times, since Apple's CDN returns `PKDownloadError`
      often enough to matter, and verified with `pkgutil` because
      `softwareupdate` can report a download error and still exit 0; the GUI
      path's wait is **bounded**. The same infinite loop could hit real hardware
      whenever that dialog was dismissed; the harness earned its keep here.
    - The session probe reads `$SSH_CONNECTION` and the owner of `/dev/console`
      rather than asking System Events, which would raise a TCC automation
      prompt on a fresh Mac — an interactive dialog in the middle of deciding
      whether anything interactive is possible.
- Long/slow steps (Xcode, large brew builds) make full runs lengthy; iteration
  should target the failing layer, not always the whole suite.
- Setup Assistant cannot be fully headless — building the golden image requires
  human clicks (documented, not automated).
- Failures are surfaced verbatim in `test/logs/`; the harness reports
  skipped/neutralized steps distinctly from passed steps.

## 13. Testing the Harness Itself

- Pure host-side helpers (e.g. VM `ENV.sh` generation, the `mas` shim, log
  parsing) get unit tests (bats) following the repo's TDD norm.
- The end-to-end VM flow is validated by an actual smoke run against the golden image
  image; there is no substitute for exercising the real path.

## 14. Success Criteria

1. From a clean clone of the golden image, the runnable suite completes and the harness
   reports a clear pass/skip/fail breakdown.
2. A full reset-and-rerun cycle takes seconds to set up (clone), not minutes.
3. An AI agent can run the suite, read `test/logs/`, fix a script on the host,
   and re-run — with no manual VM babysitting beyond the one-time image build.
4. A human can open the `tart run` window and visually confirm GUI/app/pref
   changes.
5. The tested execution path matches the real README order and scripts.

## 15. Risks & Open Questions

- **IPSW availability** — ✅ confirmed (2026-07): Apple publishes 54 restore
  images for the VM device (`VirtualMac2,1`), newest **26.5.2** (build 25F84,
  ~19.8 GB), covering the full 26.x line. `signed=False` on ipsw.me is expected
  and not a blocker — Virtualization.framework installs a VM restore image
  without live TSS signing. (Future betas still need re-checking at test time.)
- **Repo delivery mechanism** — read-only `--dir` virtiofs mount vs. `rsync` of
  the working tree vs. `git clone`. The mount tests live WIP instantly but is
  read-only (the generated `ENV.sh` and shim must live outside the mount); to be
  finalized in the implementation plan.
- **Passwordless sudo scope** — confined to the disposable test VM only; never
  applied to real hardware.
- **tart licensing** — free for personal use; confirm terms remain so.

## 16. Future Work

- Keep [MANUAL.md](../MANUAL.md) up to date with `manual_step` output.
