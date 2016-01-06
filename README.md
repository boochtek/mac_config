Mac OS X Configuration
======================

NOTE: We're in the process of moving to Ansible.
These instructions are currently in transition as well.

These scripts will configure Mac OS X the way we want, including:

  * Configuring OS preferences
  * Installing applications
  * Configuring applications

These scripts are written for Mac OS X 10.11 (El Capitan).


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
./finder.sh
./quicklook.sh
./ruby.sh
./java.sh
./terminal.sh   # NOTE: This will kill Terminal when it's done.
~~~


Ansible
-------

~~~ shell
cd mac_config
ansible2-playbook mac.yml # Requires Ansible 2.0
~~~
