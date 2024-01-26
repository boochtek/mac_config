#!/bin/bash

# NOTE: This is not included in `dev/ALL.sh`.


# Variant of the unofficial Bash strict mode.
set -uo pipefail
IFS=$'\n\t'
trap 'RC=$? ; echo "$0: Error on line "$LINENO": $BASH_COMMAND" ; exit $RC' ERR
[[ -n "${DEBUG+unset}" ]] && set -x


POSTGRES_VERSION='16'
PGUSER='pg'
PGDATA='/var/postgres'

# This includes the PostgreSQL server, client, and CLI tools (like psql).
brew install --quiet "postgresql@$POSTGRES_VERSION"

# Pgcli has auto-completion and syntax highlighting.
brew install --quiet dbcli/tap/pgcli


## PostgreSQL configuration.

# Set shared memory to 1 GB, both now and after a reboot.
sudo sysctl -w kern.sysv.shmmax=1073741824 # Was 4194304 by default on Mac OS X 10.8
sudo sysctl -w kern.sysv.shmall=262144 # (In number of 4k pages) Was 1024 by default on Mac OS X 10.8
sudo sh -c 'cat >> /etc/sysctl.conf' <<-EOF
kern.sysv.shmmax=1073741824
kern.sysv.shmall=262144
kern.sysv.shmmin=1
kern.sysv.shmmni=32
kern.sysv.shmseg=8
EOF

# Initialize the database structure.
sudo mkdir -p "$PGDATA"
pg_ctl init -D "$PGDATA" -o '-E utf8'

# Have launchd start PostgreSQL at login.
ln -sfv "$(homebrew --prefix)/opt/postgresql"/*.plist ~/Library/LaunchAgents

# Start PostgreSQL now.
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
launchctl start homebrew.mxcl.postgresql

# Create a datbase user. You'll likely have to grant them privileges.
createuser -s "$PGUSER"

# TODO: Consider installing [PostgreSQL preferences panel](https://github.com/MaccaTech/PostgresPrefs) via homebrew.
# TODO: Make sure $PGDATA gets set in startup scripts. Probably $PGUSER and $PGDATABASE too, and maybe even $PGPASSWORD.
