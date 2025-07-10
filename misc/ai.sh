#!/bin/bash

# Variant of the unofficial Bash strict mode.
set -uo pipefail
IFS=$'\n\t'
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR
[[ -n "${DEBUG+unset}" ]] && set -x

# Install [ChatGPT](https://chat.openai.com/) desktop app.
# WARNING: This requires MacOS Sonoma (14.0) or newer on Apple Silicon.
# NOTE: Includes DALL-E (generative images).
if [[ $(arch) == 'arm64' ]]; then
    brew install --quiet --cask --no-quarantine chatgpt
fi

# NOTE: GitHub Copilot is installed through VS Code.

# Anthropic Claude
brew install --quiet --cask --no-quarantine claude
npm install -g @anthropic-ai/claude-code

# TODO: Google Gemini
# TODO: Meta Llama
# TODO: Amazon Codewhisperer
# TODO: Stable Diffusion (generative images)
# TODO: Midjourney (generative images)
# TODO: Microsoft Copilot



# Whisper Assistant for VS Code uses a local Whisper AI.
# Use Command+M or click Whisper in the VS Code bottom bar to start/stop recording.
# UGH: Then you have to paste!
