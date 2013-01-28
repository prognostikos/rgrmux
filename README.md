# Rgrmux

An additional formatter for RSpec that sends messages to Tmux.

This is not original work and there's all sorts of hardcoded ugliness.

Credits:
  - @thedelchop - https://gist.github.com/4195788
  - https://github.com/guard/guard/blob/master/lib/guard/notifiers/tmux.rb
  - https://github.com/tpope/fivemat

## Installation

Clone the repo, build the gem, and install it.

## Usage

This formatter is meant to be used in addition to another formatter.

E.g. add the following to `~/.rspec`:

    --format documentation
    --format Rgrmux

## TODO
  - add formatters for Minitest & Cucumber
