TODO
====

* Make Ctrl+Shift+Down not have a special meaning in OS X, so we can use it in Atom.
* Fix sublime setup
  * Add more plugins
    * AdvancedNewFile with show_files enabled.
* Fix keyboard setup
* Remove dock items
* Prompt for hostname and set it
  * Also hard drive name
* Have it download and install Config Files
  * Prompt for github user/repo if not installed, and not in git config
* Yosemite updates
* Check that everything worked as expected
* 1Password
* brew cask install macs-fan-control # (or smcfancontrol)
* Pull down my SSL CA certificate and trust it


Ansible
-------

* Finish moving stuff over from shell scripts to Ansible
* Steal Ansible tasks from other sources:
    * https://github.com/ricbra/mac-dev-playbook
    * https://github.com/MWGriffin/ansible-playbooks
    * https://github.com/geerlingguy/mac-dev-playbook
    * https://github.com/spencergibb/ansible-osx
    * https://osxc.github.io/
    * https://github.com/spencergibb/battleschool
    * https://github.com/ansible/ansible-examples
* Steal more settings from other sources:
    * https://github.com/ricbra/dotfiles/blob/master/bin/setup_osx
    * https://github.com/pivotal-sprout/sprout-osx-settings/blob/master/recipes
    * https://github.com/boxen/puppet-osx/tree/master/manifests
    * https://github.com/bd808/puppet-osx/tree/master/manifests
    * https://github.com/xdissent/puppet-appstore


Utilities
---------

- Write a program to determine changes to `defaults` (and other config).
  - Probably make it a new sub-command of defaults+ command.
  - Start the program up.
  - Make your changes using your GUI.
  - Stop the program.
    - It'd be better to monitor in real-time, if possible.
  - The program will tell you what's been changed.
    - Will read changes to `defaults -currentHost read -g`.
    - Will read changes to `defaults -currentHost read`.
    - Will read changes to `defaults read -g`.
    - Will read changes to `defaults read`.
  - Revert your changes using your GUI.
  - Add the changes via a script, using `defaults`.


User-Specific
-------------

- Figure out how to restore from backups.
- Pull config_files from GitHub.
- Pull config_files.PRIVATE from wherever it belongs.


Keyboard Mappings
-----------------

These may be in Karabiner, or maybe just Mac key bindings.

- Map Command+Shift+, to open System Preferences.
  - Because Command+, is the standard keystroke to open Preferences in applications.
  - open "/Applications/System Preferences.app"
- Make Ctrl+Tab, Ctrl+PageDown cycle through tabs.
  - Probably Command+Right (or Option or Ctrl) too.
  - And corresponding key binding for reverse cycling.
- Make Ctrl+Enter, Command+Enter send email (in Mail, Thunderbird, and all other email programs).
- Do magic to make Finder opening and renaming more sane.
