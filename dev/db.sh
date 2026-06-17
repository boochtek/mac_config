#!/bin/bash

## Databases

# Usql is a modern "universal" DB CLI/REPL inspired by `psql`.
# It has drivers for PostgreSQL, MySQL, SQLite, SQL Server, Oracle, and CSV.
brew trust --formula xo/xo/usql
brew install --quiet xo/xo/usql
