Dotfiles
========
## Setup

- __script/bootstrap:__ Run this script to create symlinks and do anythin else for the environment. This is meant to be run periodically.
- __script/install:__ Run this script to execute the topic/install.sh scripts.
- __dot:__ Run this script now and then to keep everything up to date. This is run from _script/bootstrap_.


## Layout

- __topic/*.zsh:__ These files are sourced when opening a new shell.
- __topic/*.symlink:__ These files are symlinked into the home directory as _.filename_
- __topic/path.zsh:__ These files are for defining the path. They are sourced early.
- __topic/completion.zsh:__ These files are for setup up completion and are sourced last.
- __topic/env.zsh:__ These files contain environment variables needed for non-interactive shells that are not sensitive.
- __topic/*.bin:__ These are scripts for executing and are symlinked into bin.
- __topic/install.sh:__ This script should install anything needed to work within the topic.
- __topic/install.osx:__ This script should install anything needed for osx only.
- __topic/dot.sh:__ This script should update anything needed to be updated for the topic. It's run from the dot script.
- __topic.symlink/:__ Link the entire directory into home.
- __bin/:__ This directory is added to $PATH.

## Private Stuff
- __~/.localenv:__ Will be loaded by .zshenv
- __~/.localrc:__ Will be loadede by .zshrc
