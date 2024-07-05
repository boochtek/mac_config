

# NOTE: This will install the Cask version. The non-Cask version is not as up-to-date.
# NOTE: The Cask version now includes Docker Compose.
brew install --quiet --cask --no-quarantine docker

# Lazydocker provides a nice TUI for Docker and Docker Compose.
# NOTE: If you want newer versions, use `jesseduffield/lazydocker/lazydocker`.
brew install --quiet lazydocker
