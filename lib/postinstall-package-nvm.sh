#!/usr/bin/env bash
set -e

[ ! isDarwin  ] && \
    echo "Warning: not available for this OS" && \
    exit 1

_path_nvm_home="$HOME/.nvm"
_path_nvm_opt="$(brew --prefix nvm)"

# if no nvm home folder is available, create it.
[ ! -d $_path_nvm_home ] && mkdir $_path_nvm_home

# make sure the nvm command is available
source "$_path_nvm_opt/nvm.sh"

# list the latest nvm LTS version available, and install it
_nvm_ver=$(nvm ls-remote | grep "Latest LTS" | tail -n 1 | xargs | cut -d " " -f1)
    nvm install $_nvm_ver

# set the latest node version as default
nvm use default node

