#!/bin/bash

# MacOS 12 (Monterey) comes with Bash 3.2. This will upgrade that to Bash 5.1.
brew install bash

# Install Bash command-line completion.
brew install bash-completion

# Allow Homebrew version of Bash to be used as login shell.
# sudo ansible localhost -m lineinfile -a "dest=/etc/shells line=/usr/local/bin/bash"
if ! grep "$(brew --prefix)/bin/bash" /etc/shells >/dev/null; then
    sudo sh -c "echo '$(brew --prefix)/bin/bash' >> /etc/shells"
fi

# Use newer Bash from Homebrew if we're using the system Bash.
if [[ "$(dscl . -read ~ UserShell | sed 's/UserShell: //')" == '/bin/bash' ]]; then
    chsh -s "$(brew --prefix)/bin/bash" "$USER"
fi
