TODO
====

Get all these (mostly) finished, in order to be useful
------------------------------------------------------

os/xcode-clt.sh         (untested)
os/dock.sh              (done)
os/finder.sh            (probably needs updates)
os/homebrew.sh          (untested)
os/hostname.sh          (untested)
os/menubar.sh           (probably needs updates)
os/misc.sh              (probably needs updates)
hardware/trackpad.sh    (probably needs updates)
hardware/printer.sh     (TODO)
web/browsers.sh         (probably needs updates)
editors/vim.sh          (may need updates)
email/mail.sh           (probably needs updates)
email/thunderbird.sh    (probably needs updates)
dev/*.sh                (untested)

Then see what's missing from the Ansible branch.
TODO: Document Xcode CLT prerequisite.
TODO: See what we can add for Big Sure (MacOS 11.0)

Probably really old stuff
-------------------------
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
* brew install --no-quarantine --cask macs-fan-control # (or smcfancontrol)


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
