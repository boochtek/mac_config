Mac OS X Configuration
======================

These Ansible playbooks will configure Mac OS X the way we want, including:

  * Configuring OS preferences
  * Installing applications
  * Configuring applications

These scripts are written for Mac OS X 10.11 (El Capitan).
Ansible 2.1 is required, due to a couple features we're using.


Usage
-----

First, clone the repository:

~~~ shell
git clone https://github.com/boochtek/mac_config.git
cd mac_config
~~~

Then run the playbook:

~~~ shell
ansible-playbook -K mac.yml
~~~

You'll be prompted for your password, as well as your Mac App Store ID and password.
You can just hit enter on the Mac App store prompts, if you won't be installing anything from the Mac App Store. Currently, we're only installing Markoff, a Markdown reader.

Most roles and included tasks have tags, so you can run a subset of tasks.
This can be helpful when writing and testing a new task.
For example:

~~~ shell
ansible-playbook -K mac.yml -t keyboard
~~~

You can also leave out the `-K` if you know you won't need sudo access,
and you won't be prompted for your password.
