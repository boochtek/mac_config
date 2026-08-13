# Makefile — mac-setup VM test harness. Run `make` (or `make help`) for targets.
#
# IMAGE names the VM image, one per macOS version. It defaults to this Mac's
# current version — `make image` then builds an image matching the OS you run —
# so override it only for a different version, e.g. a beta:
#   make image IMAGE=mac-setup-27b2 IPSW=<beta-ipsw-url>
IMAGE ?= mac-setup-$(shell sw_vers -productVersion)

# Per-run flags (accept true/1/yes/on). Runs show a VM window by default: while
# the suite is still being debugged, a blocking GUI prompt is indistinguishable
# from a hang in the logs. Flip HEADLESS to true here once runs are reliably
# green — headless is faster and won't steal focus.
KEEP ?= false
HEADLESS ?= false

# Source image for `make clone` (NEW names the copy).
FROM ?= $(IMAGE)

# Admin account inside the VM. Defaults to this Mac's login name; set it if you
# named the VM's account differently: make access VM_USER=someone-else
VM_USER ?= $(shell id -un)

# Key pair used for unattended access to the VMs.
SSH_KEY ?= $(HOME)/.ssh/mac-setup-vm

.DEFAULT_GOAL := help

.PHONY: help setup install-tools image boot access freeze clone test \
	logs follow-logs list-vms ssh clean clean-image clean-cache fmt lint

help: ## List available targets
	@grep -E '^[a-zA-Z0-9_-]+:.*## ' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*## "} {printf "  %-14s %s\n", $$1, $$2}'
	@echo ""
	@echo "  IMAGE=$(IMAGE) (override to test another macOS version)"

# --- One-time setup ---

setup: install-tools ## Install host dependencies (one-time); then run `make image`

install-tools: ## Install tart (host tooling)
	./test/install-tools.sh

image: ## Download the IPSW and build the VM image
	IMAGE=$(IMAGE) ./test/create-image.sh

boot: ## Boot the image's window (for the one-time manual setup)
	tart run $(IMAGE) &

access: ## Grant the image SSH-key access + passwordless sudo (after Remote Login)
	IMAGE=$(IMAGE) VM_USER=$(VM_USER) ./test/setup-access.sh

freeze: ## Shut down the image to freeze it as the pristine clone base
	tart stop $(IMAGE)

clone: ## Duplicate an image: make clone NEW=mac-setup-27b2 [FROM=$(IMAGE)]
	@test -n "$(NEW)" || { echo "usage: make clone NEW=<new-image> [FROM=<source-image>]"; exit 1; }
	tart clone $(FROM) $(NEW)

# --- Testing ---

test: ## Run the suite on a fresh clone  (KEEP=true, HEADLESS=true, RUN_GROUPS='os shell')
	IMAGE=$(IMAGE) VM_USER=$(VM_USER) KEEP=$(KEEP) HEADLESS=$(HEADLESS) ./test/run.sh

logs: ## Show the newest test-run log
	@latest=$$(ls -t test/logs/*.log 2>/dev/null | head -1); \
		[ -n "$$latest" ] && cat "$$latest" || echo "no logs yet"

follow-logs: ## Tail the newest test-run log live (watch a run in progress)
	@latest=$$(ls -t test/logs/*.log 2>/dev/null | head -1); \
		[ -n "$$latest" ] && tail -f "$$latest" || echo "no logs yet"

# --- VM management ---

list-vms: ## List tart VMs
	tart list

ssh: ## SSH into the active run clone, else the image (e.g. to watch a download)
	@vm=$$(tart list | grep -oE 'mac-setup-run-[0-9-]+' | head -1); \
		vm=$${vm:-$(IMAGE)}; \
		ip=$$(./test/lib/vm-ip "$$vm") || { echo "no IP for $$vm — is it running?"; exit 1; }; \
		echo "$$vm at $$ip"; \
		ssh -i $(SSH_KEY) -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
			-o LogLevel=ERROR $(VM_USER)@$$ip

clean: ## Delete leftover run clones (mac-setup-run-*)
	@for vm in $$(tart list | grep -oE 'mac-setup-run-[0-9-]+'); do \
		echo "deleting $$vm"; tart delete "$$vm"; \
	done; true

clean-image: ## Delete the VM image (rebuild with `make image`)
	-tart stop $(IMAGE)
	tart delete $(IMAGE)

clean-cache: ## Delete tart's cached IPSWs (~20 GB each; re-downloaded on demand)
	tart prune --entries caches --older-than 0

# --- Code quality ---

fmt: ## Format the harness scripts with shfmt
	shfmt -w test/

lint: ## shfmt + shellcheck the harness scripts
	shfmt -d test/
	shellcheck test/*.sh test/lib/mas
