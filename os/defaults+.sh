#!/bin/bash

# Make sure we have latest defaults+.

sudo chown root:staff /usr/local/bin
sudo chmod g+w /usr/local/bin
curl --silent -o /usr/local/bin/defaults+ https://raw.githubusercontent.com/boochtek/defaults_plus/master/defaults+
chmod a+x /usr/local/bin/defaults+
python3 -m pip install pyobjc
hash -r
