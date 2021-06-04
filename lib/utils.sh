#!/bin/bash
# Used for letting know the script that this file has already been loaded
DOTFILES_UTILS=true

# obtain the absolute route to the folder containing this file
export DOTFILES_LIB="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
export DOTFILES_ROOT=${DOTFILES_LIB%/*}
export DOTFILES_BIN="$DOTFILES_ROOT/bin"
export DOTFILES_SRC="$DOTFILES_ROOT/dotfiles"
export DOTFILES_LNK="$DOTFILES_ROOT/private"
export DOTFILES_ENV="$DOTFILES_ROOT/private/env"

# Make sure the root directory was obtained correctly
[ ! -d $DOTFILES_ROOT ] &&  echo "Invalid root directory." && exit 1;

function isGIT {
    git status > /dev/null 2> /dev/null
}

function isDarwin {
    test `uname -s` = 'Darwin'
}

function isLinux {
    test `uname -s` = 'Linux'
}

function isArch {
    test -f '/etc/arch-release'
}

function isListed {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

# Determines if a string is in a CSV string
# @param {csv string} $1 - A string with CSV (no spaces)
# @param {string} $2 - A string to find in CSV
function inCSV {
    for i in $(echo $1 | sed "s/,/ /g"); do
        [[ $2 = $i ]] && return 0
    done
    return 1
}

function has {
    test $(command -v $1 > /dev/null &> /dev/null)
}

function dotfiles {
    # try first the unix way, then the bsd way. (brew might be already installed)
    {
        find $1 -maxdepth 1 ! -path $1 -exec basename {} \;
    } || {
        find $1 -depth 1 ! -path $1 -exec basename {} \;
    }
}

# make usr/local writable to everyone in the same group as current user
function perms {
    sudo -k chown -R $(id -u):$(id -g) /usr/local
    sudo -k chmod -R u+rw,g+rw,o-rwx /usr/local
}

function getLinkPath {
    # get until the very end of the (possible) symlink sequence
    local target=$1
    cd ${target%/*}
    target=`basename $target`
    while [ -L "$target" ]; do
        target=`readlink $target`
        cd ${target%/*}
        target=`basename $target`
    done
    echo `pwd -P`
}

# Set environment variable based upon a file
function setEnv {
    export $1="`cat $DOTFILES_ENV/$1 2> /dev/null`"
}

