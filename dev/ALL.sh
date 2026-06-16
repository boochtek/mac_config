#!/bin/bash

# Run from this script's own directory so each sub-script's relative paths resolve.
cd "$(dirname "$0")" || exit 1

./xcode.sh
./git.sh
./github.sh
#./asdf.sh
./mise.sh
./docker.sh
./js.sh
./ruby.sh
./java.sh
./rust.sh
./elm.sh
./roc.sh
./python.sh
./llvm.sh
./crystal.sh
./racket.sh
./nim.sh
./elixir.sh
./ocaml.sh
./haskell.sh
./io.sh
./clojure.sh
./lua.sh
./shell.sh
./dbeaver.sh

## TODO: Rust
## TODO: Scala
## TODO: Idris
## TODO: Factor
## TODO: Forth
## TODO: Rakudo (Perl 6)
## TODO: Prolog
## TODO: Kotlin
