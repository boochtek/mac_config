Mac OS X Configuration
======================

These scripts will configure Mac OS X the way we want, including:

  * Configuring OS preferences
  * Installing applications
  * Configuring applications

These scripts are written for Mac OS X 10.9 (Mavericks).
The scripts should all be idempotent.
(That means that you can run them as many times as you want.)


Usage
-----

First, clone the repository:

~~~ shell
git clone https://github.com/boochtek/mac_config.git
~~~

Theoretically, any of these scripts could be run independently.
However, we run them in this order when installing a new system:

~~~ shell
cd mac_config
./xcode.sh      # NOTE: May take a long time (perhaps an hour).
./trackpad.sh
./homebrew.sh
./misc.sh
./keyboard.sh
./finder.sh
./menubar.sh
./quicklook.sh
./java.sh
./ruby.sh
./vim.sh
./sublime.sh
./atom.sh
./twitter.sh
./mail.sh
./safari.sh
./terminal.sh   # NOTE: This will kill Terminal when it's done.
~~~
