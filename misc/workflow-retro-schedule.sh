#!/bin/bash

# Monthly AI workflow retro — installs a launchd agent that runs Claude
# Code's `/workflow-retro --auto` slash command on the 1st of each month.
#
# Requires:
#   * workflow-retro command — ~/.claude/commands/workflow-retro.md
#     (canonical: ~/.config/ai/commands/workflow-retro.md)
#
# --auto mode is report-only: it mines recent session transcripts across
# Claude Code / Codex / OpenCode for recurring friction and writes a report
# to ~/.local/share/ai/retro-log/<YYYY-MM>.md. It applies no fixes, so the
# unattended run needs no destructive permissions.
#
# Note: launchd runs a missed StartCalendarInterval job on wake from sleep,
# but NOT after being powered off — if the Mac is shut down all day on the
# 1st, that month's retro is skipped (run `/workflow-retro` manually).

# 1. Wrapper script (~/bin/workflow-retro-monthly) — what launchd actually runs.
mkdir -p "$HOME/bin"
cat >"$HOME/bin/workflow-retro-monthly" <<'WRAPPER'
#!/usr/bin/env bash
# Monthly AI workflow retro — runs the /workflow-retro slash command via
# Claude Code in non-interactive mode and logs the result. Scheduled by:
#   ~/Library/LaunchAgents/com.boochtek.workflow-retro.plist
# Setup script:
#   ~/mac-setup/misc/workflow-retro-schedule.sh

set -uo pipefail

LOG_ROOT="$HOME/.local/share/ai/retro-log"
mkdir -p "$LOG_ROOT"
MONTH="$(date +%Y-%m)"
LOG="$LOG_ROOT/$MONTH-run.log"

# launchd hands us a minimal PATH; restore the usual one.
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.local/bin:$HOME/bin:$PATH"

{
    echo "# Workflow retro — $MONTH $(date +%H:%M:%S)"
    echo ""

    claude -p "/workflow-retro --auto" --output-format text || {
        rc=$?
        echo ""
        echo "claude -p exited $rc"
        osascript -e 'display notification "Workflow retro failed — see ~/.local/share/ai/retro-log/" with title "Workflow retro failed"'
        exit "$rc"
    }

    echo ""
    echo "Done $(date +%H:%M:%S)"
    osascript -e 'display notification "Report in ~/.local/share/ai/retro-log/ — review and apply fixes" with title "Monthly workflow retro done"'
} | tee "$LOG"
WRAPPER
chmod +x "$HOME/bin/workflow-retro-monthly"

# 2. launchd agent plist. Fires on the 1st of each month at 07:17 local.
mkdir -p "$HOME/Library/LaunchAgents"
cat >"$HOME/Library/LaunchAgents/com.boochtek.workflow-retro.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.boochtek.workflow-retro</string>

    <key>ProgramArguments</key>
    <array>
        <string>$HOME/bin/workflow-retro-monthly</string>
    </array>

    <key>StartCalendarInterval</key>
    <dict>
        <key>Day</key>
        <integer>1</integer>
        <key>Hour</key>
        <integer>7</integer>
        <key>Minute</key>
        <integer>17</integer>
    </dict>

    <key>RunAtLoad</key>
    <false/>

    <key>WorkingDirectory</key>
    <string>$HOME/.config</string>

    <key>StandardOutPath</key>
    <string>$HOME/.local/share/ai/retro-log/launchd.out</string>
    <key>StandardErrorPath</key>
    <string>$HOME/.local/share/ai/retro-log/launchd.err</string>

    <key>EnvironmentVariables</key>
    <dict>
        <key>HOME</key>
        <string>$HOME</string>
        <key>PATH</key>
        <string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin</string>
    </dict>

    <key>ProcessType</key>
    <string>Background</string>
</dict>
</plist>
PLIST

# 3. Bootstrap the agent (idempotent: bootout first, then bootstrap).
launchctl bootout "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.boochtek.workflow-retro.plist" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.boochtek.workflow-retro.plist"

# 4. Ensure log directory exists.
mkdir -p "$HOME/.local/share/ai/retro-log"

# Verify with:
#   launchctl print "gui/$(id -u)/com.boochtek.workflow-retro"
# Force a test run with:
#   launchctl kickstart -k "gui/$(id -u)/com.boochtek.workflow-retro"
# Disable temporarily:
#   launchctl bootout "gui/$(id -u)" ~/Library/LaunchAgents/com.boochtek.workflow-retro.plist
