TODO
====

* Automate accepting the license of the latest version of XCode
    * xcode_version=$(defaults read /Applications/Xcode.app/Contents/Resources/LicenseInfo licenseID)
    * sudo defaults write /Library/Preferences/com.apple.dt.Xcode IDELastGMLicenseAgreedTo $xcode_version
    * Hat tip to https://macops.ca/deploying-xcode-the-trick-with-accepting-license-agreements
* Make Ctrl+Shift+Down not have a special meaning in OS X, so we can use it in Atom.
* Move Mac App Store stuff to its own file; include it for Markoff.
* Fix keyboard setup
* Remove dock items
* Have it download and install Config Files
    * Prompt for github user/repo if not installed, and not in git config
* MacOS Sierra updates
* Check that everything works as expected
* 1Password
* brew cask install macs-fan-control # (or smcfancontrol)
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
* Keyboard config.
    * Double-tap caps-lock for caps-lock.
    * Hold caps-lock for Ctrl.
    * Tap caps-lock for Esc.
    * Hold Esc for Hyper.
    * Hold Tab for Super.
    * Make Ctrl+Tab work right in Terminal.


Ansible
-------

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


Sublime Text
------------

* Consider not installing/configuring it an more
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
