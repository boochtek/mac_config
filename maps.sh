#!/bin/bash

## Helper functions for working with "maps" in Bash 3.
## The "maps" are arrays of strings, each string being a key, followed by '=', followed by the value.


# Given a map and a key, returns the value from the map.
function map_value_for_key {
  local key_to_find="${@: -1}"
  local map=("$@")
  unset map[${#map[@]}-1]
  for mapping in "${map[@]}" ; do
    local key=${mapping%%=*}
    local value=${mapping#*=}
    if [ "$key_to_find" == "$key" ]; then
      echo "$value"
      return
    fi
  done
}


function map_keys {
  local map=("$@")
  local mapping
  for mapping in "${map[@]}" ; do
    local key=${mapping%%=*}
    echo "$key"
  done
}

function map_values {
  local map=("$@")
  local mapping
  for mapping in "${map[@]}" ; do
    local value=${mapping#*=}
    echo "$value"
  done
}

