MacOS Configuration
====================

These scripts will configure MacOS the way we want, including:

* Configuring OS preferences
* Installing applications
* Configuring applications

These scripts are written for MacOS 10.15 (Catalina),
but we've been using them since at least 10.9 (Mavericks).
We'll be updating them for MacOS 10.16 (Big Sur) soon.

The scripts should all be idempotent.
(That means that you can run them as many times as you want.)

Usage
-----

First, clone the repository:

~~~ shell
git clone https://github.com/boochtek/mac_config.git
cd mac_config
~~~

Next, edit the config files:
* inventory_for_mac_serial_number.sh - add your computer to the list
* appstore_apps_to_install.yml - list of App Store apps to be installed

Theoretically, any of these scripts could be run independently.
(Except for the `util` directory, which contains shared code imported by other scripts.)
However, there are some (likely not adequately documented) dependencies.
This order should work:

~~~ shell
os/ALL.sh
hardware/ALL.sh
shell/ALL.sh
editors/ALL.sh
email/ALL.sh
web/ALL.sh
dev/ALL.sh
~~~

Many scripts will prompt for your password, as they require `sudo` to install various programs and settings.
Others might ask for other passwords, for example your Mac App Store ID and password.
You can just hit **Enter** on the Mac App store prompts, if you won't be installing anything from the Mac App Store.

Note that some of the scripts might take a while to run.
For example, installing Xcode may take over an hour.
The entire set of scripts will take several hours to run;
many packages will be downloaded and compiled.
Even if nothing new needs to be installed, the scripts could take about 8 minutes to run.


~~~ shell
./misc.sh
./finder.sh
./terminal.sh   # NOTE: This will kill Terminal when it's done.
~~~

## Bash 3.2

Keep in mind that MacOS ships with Bash 3.2.
It likely will never ship with anything newer, due to Apple's dislike of GPLv3.
So we can't use any features introduced in Bash 4 or later:
* Associative arrays
* Case-modification operators for parameter substitution
* Globbing with `**` to match recursively
* Escape codes in strings with `\u` and `\U` to represent Unicode characters
* Negative array indices


## Downloading and Installing MacOS Sonoma

diskutil list external physical
diskutil info -all

diskutil partitionDisk <device> GPT JHFS+ 'Sonoma Installer'

~~~ shell
softwareupdate --fetch-full-installer
sudo '/Applications/Install macOS Monterey.app/Contents/Resources/createinstallmedia' \
  --volume '/Volumes/Sonoma Installer'
~~~
