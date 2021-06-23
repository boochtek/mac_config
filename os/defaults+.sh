#!/bin/bash

# Make sure we have latest defaults+.

curl --silent -o /usr/local/bin/defaults+ https://raw.githubusercontent.com/boochtek/defaults_plus/master/defaults+
chmod a+x /usr/local/bin/defaults+
hash -r
