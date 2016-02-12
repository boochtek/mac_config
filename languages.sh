#!/bin/bash

### Programming Languages.

source 'homebrew.sh'


## Elm
brew install elm


## TODO: Make sure Shard is included.
## Crystal is a Ruby-like lanugage, compiled, with type inference.
brew install crystal-lang --with-llvm


## Racket
## Racket is a superset of Scheme, that allows defining other languages (per module).

# Install only the `racket` and `raco` executables; no DrRacket IDE.
brew install plt-racket

# Install extended REPL library, so we can use Readline.
# NOTE: You'll want `(require xrepl)` in your `~/.racketrc` file to enable this.
raco pkg install --auto xrepl

# TODO: Install Swindle, to get a better object system, more like CLOS.


## OCaml
brew install ocaml


## Haskell
brew install ghc


## Io

# Install the required XQuartz first. NOTE: Requires password interactively.
brew cask install xquartz

# Install the language itself.
brew install io


## Clojure
brew install leiningen
# TODO: follow the tutorial: https://github.com/technomancy/leiningen/blob/stable/doc/TUTORIAL.md
# TODO: To play around with Clojure run `lein repl` or `lein help`.


## Factor
brew cask install factor


## TODO: Forth


## Perl 6
brew install rakudo-star


## Rust
brew install rust


## Scala
brew install scala


## TODO: Erlang


## TODO: Prolog


## TODO: Lua


## TODO: Elixir


## TODO: Idris


## TODO: Kotlin
