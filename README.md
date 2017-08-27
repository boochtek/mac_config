Mac OS X Configuration
======================

These Ansible playbooks will configure Mac OS X the way we want, including:

  * Configuring OS preferences
  * Installing applications
  * Configuring applications

These scripts are written for Mac OS X 10.11 (El Capitan).
Ansible 2.1 is required, due to a couple features we're using.

Note that some of the tasks will prompt you for your password to complete the installation,
so this isn't a 100% "fire-and-forget" process.


Usage
-----

First, clone the repository:

~~~ shell
git clone https://github.com/boochtek/mac_config.git
cd mac_config
git checkout ansible
~~~

Next, edit `inventory_for_mac_serial_number.sh` to add your computer to the list.

Then edit `mac_vars.yml` to your preferences.

Finally, run the playbook:

~~~ shell
ansible-playbook -K mac.yml
~~~

You'll be prompted for your password, as well as your Mac App Store ID and password.
You can just hit `Enter` on the Mac App store prompts, if you won't be installing anything from the Mac App Store.
The list of App Store apps to be installed are listed in `appstore_apps_to_install` in the `mac_vars.yml` file.

Most roles and included tasks have tags, so you can run a subset of tasks.
This can be helpful when writing and testing a new task.
For example:

~~~ shell
ansible-playbook -K mac.yml -t keyboard
~~~

You can also leave out the `-K` if you know you won't need sudo access,
and you won't be prompted for your password.
