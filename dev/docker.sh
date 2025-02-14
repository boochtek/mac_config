

# NOTE: This will install the Cask version. The non-Cask version is not as up-to-date.
# NOTE: The Cask version now includes Docker Compose.
brew install --quiet --cask --no-quarantine docker

# Lazydocker provides a nice TUI for Docker and Docker Compose.
# NOTE: If you want newer versions, use `jesseduffield/lazydocker/lazydocker`.
brew install --quiet lazydocker

# Install Kubernetes CLI tool.
brew install --quiet kubernetes-cli

# Install kubectx and kubens to switch between Kubernetes contexts and namespaces.
brew install --quiet kubectx

# Install some TUI apps to get info on Kubernetes clusters.
brew install --quiet ktop
brew install --quiet kdash
