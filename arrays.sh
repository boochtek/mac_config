#!/bin/bash

## Helper functions for working with arrays in Bash.


# Given a string and an array, returns true (0) iff the array contains the string.
# Adapted from http://stackoverflow.com/a/8574392.
function array_contains {
  local e
  for e in "${@:2}"; do
    [[ "$e" == "$1" ]] && return 0;
  done
  return 1
}
