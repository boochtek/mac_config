TODO
====

* Remove duplication in misc and dev-tools
    * SCM stuff
    * Ack stuff
    * man pages

* Ansible updates
    * Figure out the deal with having to have `add_to_dock.yml` in the top-level directory
        * Probably need to change `include: add_to_dock.yml` to `import_task` or `include_task`
    * Use `ansible_facts.xyz` instead of `ansible_xyz` for any facts
        * WARNING: I believe that some `ansible_xyz` items are NOT facts, but magic variables
    * Replace `with_xyz` with `loop`
        * See https://docs.ansible.com/ansible/latest/porting_guides/porting_guide_2.5.html#migrating-from-with-x-to-loop
* Make sure locate DB is generated/updated
* Update to latest Ruby versions
    * Make sure the necessary gems are also installed
    * Don't forget to include the handler
    * Remove the ruby vars -- they're not used
* Pull in everything from CenturyLink laptop
* Install Node, Yarn, and some commonly-used packages
* Automate accepting the license of the latest version of XCode
    * xcode_version=$(defaults read /Applications/Xcode.app/Contents/Resources/LicenseInfo licenseID)
    * sudo defaults write /Library/Preferences/com.apple.dt.Xcode IDELastGMLicenseAgreedTo $xcode_version
    * Hat tip to https://macops.ca/deploying-xcode-the-trick-with-accepting-license-agreements
* Make Ctrl+Shift+Down not have a special meaning in OS X, so we can use it in Atom.
    * com.apple.symbolichotkeys / AppleSymbolicHotKeys / 35 / enabled = 0
    * See http://krypted.com/mac-os-x/defaults-symbolichotkeys/
    * Both 33 and 35 got disabled
        * 33 is listed as Application Windows
            * It's got only Control applied
        * 35 is not listed, and I only changed 1 thing
            * It's got Control and Shift applied to the same keycode (125)
    * Better yet, remap it to the same thing with Alt (and maybe Command) added
* Move Mac App Store stuff to its own file; include it for Markoff.
* Fix keyboard setup
* iTunes settings
    * Don't auto-start every time iPad is plugged in
        * Same with Photos app
    * Don't copy MP3s from their source location into iTunes
        * Preferences / Advanced / UNCHECK Copy files to iTunes Media folder when adding to library
    * Set MP3 ripping settings (double-check that these are what I've been using)
        * Preferences / General / Import Settings
            * Import Using: MP3 Encoder
            * Settings: Custom
                * Stereo Bit Rate: 192 kbps
                * CHECK Use Variable Bit Rate Encoding (VBR)
                * Quality: Highest
            * CHECK Use error correction when reading audio CDs
* Remove dock items
* Move Mac App Store stuff to its own file; include it for Markoff.
* Have it download and install Config Files
    * Prompt for github user/repo if not installed, and not in git config
* brew cask install macs-fan-control # (or smcfancontrol)
    * I've been pretty happy with smcFanControl 2.6
* MacOS Sierra updates
* MacOS High Sierra updates
* Check that everything works as expected
    * Wipe system and reinstall to test everything fully
        * Be sure to get a good backup first
* Install and configure 1Password
    * Isn't 1Password included via Mac App Store?
    * Perhaps in a `security.yml` file?
* Install and configure browsers
    * Safari (configuration only, obviously)
    * Google Chrome
    * Firefox
    * Chromium
    * The one that's specifically made for development
* Other email clients
    * Airmail
    * Postbox
    * MailMate
    * Spark
* Install and configure Slack
* Install Sublime Text?
* Pull down my SSL CA certificate and trust it
* Add items to Sidebar Favorites (com.apple.sidebarlists):
    * Personal
    * Work
    * Projects
    * Utilities
* Remove items from Sidebar Favorites (com.apple.sidebarlists):
    * All My Files
    * iCloud Drive
    * Airdrop


Bug Reports
-----------

* Control+F8 doesn't work correctly with 1Password (6.7)
    * Should focus on the status menu
    * System Preferences / Keyboard / Shortcuts / Keyboard
* Control+F8 doesn't work correctly with Magnet (2.1.0)
    * Should focus on the status menu
    * System Preferences / Keyboard / Shortcuts / Keyboard


Keyboard Mappings
-----------------

* System Preferences -> Keyboard -> Shortcuts
    * DISABLE Mission Control / Mission Control
        * The Ctrl+Up conflicts with Atom/Sublime block selection mode
    * DISABLE Mission Control / Application Windows
        * The Ctrl+Down conflicts with Atom/Sublime block selection mode
    * DISABLE Mission Control / Move left a space
    * DISABLE Mission Control / Move right a space
    * DISABLE Mission Control / Show Desktop
        * F11 should be a regular function key
        * I don't keep anything on my desktop
    * DISABLE Mission Control / Show Dashboard
        * F12 should be a regular function key
    * CHANGE Mission Control / Switch to Desktop 1
        * Command+Control+Option+1
    * CHANGE Mission Control / Switch to Desktop 2
        * * Command+Control+Option+2
    * ADD App Shortcuts / Finder.app / Rename: F2
    * ADD App Shortcuts / Thunderbird.app / Send Now: Command+Enter
    * ADD App Shortcuts / Thunderbird.app / Send: Command+Enter
* Set some global app key-bindings (can also set them per app) (preferences calls tab \U21E5, but it should probably be \U0011):
    ~~~ shell
    defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Select Next Tab"      '^\U21E5'
    defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Select Previous Tab"  '^~\U21E5'
    defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Next Tab"             '^\U21E5'
    defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Previous Tab"         '^~\U21E5'
    ~~~


Ansible
-------

* Use 4-space indentation
* Finish moving stuff over from shell scripts to Ansible
    * Terminal key-bindings is a big one
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
* Ansible
    * I think I might be treating playbooks as plays, plays as roles, so each role I'm making is too big
        * Should make a playbook with several plays, instead of 1 play with several roles


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


Programming Languages
---------------------

* Install a bunch of programming languages
    * crystal.yml
    * elixir.yml
    * erlang.yml
    * ocaml.yml
    * perl.yml
    * clojure.yml
    * idris.yml
    * rust.yml # Don't forget to brew install rustc-completion
    * haskell.yml
    * scala.yml
    * kotlin.yml
    * io.yml
    * lua.yml
    * factor.yml
    * pony.yml
    * prolog.yml


User-Specific
-------------

- Figure out how to restore from backups.
- Pull config_files from GitHub.
- Pull config_files.PRIVATE from wherever it belongs.


Sublime Text
------------

* Consider NOT installing/configuring it any more
* Add more plugins
    * AdvancedNewFile with show_files enabled.
* Here's some stuff from a while back:
    ~~~
    curl http://sublime.wbond.net/Package%20Control.sublime-package -o ~/Library/Application\ Support/Sublime\ Text 3/Installed\ Packages/Package\ Control.sublime-package
    SUBLIME_PACKAGE_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages"
    (cd "$SUBLIME_PACKAGE_DIR" && git clone https://github.com/bitbonsai/sublime-jquery-snippets 'jQuery Snippets')
    (cd "$SUBLIME_PACKAGE_DIR" && git clone https://github.com/tadast/sublime-rails-snippets 'Rails Snippets')
    (cd "$SUBLIME_PACKAGE_DIR" && git clone https://github.com/chriskempson/base16-textmate 'Base16')
    TODO:
          (cd "$SUBLIME_PACKAGE_DIR" && git clone https://github.com/SublimeLinter/SublimeLinter3 'SublimeLinter')
          (cd "$SUBLIME_PACKAGE_DIR" && git clone .... 'SublimeLinter-eshint')
          (cd "$SUBLIME_PACKAGE_DIR" && git clone .... 'SublimeLinter-jshint')
          (cd "$SUBLIME_PACKAGE_DIR" && git clone .... 'SublimeLinter-rubocop')
          (cd "$SUBLIME_PACKAGE_DIR" && git clone https://github.com/SublimeCodeIntel/SublimeCodeIntel 'SublimeCodeIntel')
          (cd "$SUBLIME_PACKAGE_DIR" && git clone .... '')
          (cd "$SUBLIME_PACKAGE_DIR" $$ git clone https://github.com/mrmartineau/HTML5 'HTML5')
          (cd "$SUBLIME_PACKAGE_DIR" $$ git clone https://github.com/SublimeText/Tag 'Tag')


    subl --command 'install_package package = "https://github.com/mrmartineau/HTML5"'
    subl --command 'window.run_command("add_repository", "https://github.com/mrmartineau/HTML5")'
    ~~~
    ~~~ python
    def install_package(package_name):
        package_manager = package_control.package_manager.PackageManager()
        thread = package_control.package_installer.PackageInstallerThread(package_manager, package_name, None)
        thread.start()
        package_control.thread_progress.ThreadProgress(thread, 'Installing package %s' % package_name,
                                                               'Package %s successfully installed' % package_name)
    install_package('SublimeLinter')
    ~~~
    - Save ~/Library/Application\ Support/Sublime\ Text\ 3/Local/Session.sublime_session
    - License
    - Basics
    - Theme
      - Would probably prefer tomorrow, with a yellow background like `solarized.light`.
      - Need to add Markdown styles to base16.solarized.light and base16.tomorrow.light (and dark themes).
        - Get them from Packages/MarkdownEditing/MarkdownEditor.tmTheme
    - Spelling = custom dic.
      - Keep custom dic in config_files.
      - Turn on spell check. (spell_check: true in config file, F6 afterwards)
      - Consider trying CheckBounce as an alternate spell checker.
    - Fix Ctrl+Tab to next tab.
    - Document (and/or commit) config.
      - Installed packages
        - Markdown​Editing
        - AutoWrap
        - RubyRefactoring
        - Simple Print Function
        - RSpec
        - ApplySyntax
        - Git
        - All Autocomplete
        - BeautifyRuby
        - SideBarEnhancements
        - GitGutter
        - Better CoffeeScript
