#!/bin/bash

# Used to let know script that this file has already been loaded
DOTFILES_UTILS=true

# obtain the absolute route to the folder containing this file
pushd ${BASH_SOURCE%/*} > /dev/null
DOTFILES_LIB=`pwd -P`
popd > /dev/null

DOTFILES_ROOT=${DOTFILES_LIB%/*}
DOTFILES_SRC="$DOTFILES_ROOT/dotfiles"

function isDarwin {
    test `uname -s` = 'Darwin'
}

function isLinux {
    test `uname -s` = 'Linux'
}

function isArch {
    test -f '/etc/arch-release'
}

function has {
    if `command -v $1 > /dev/null 2>&1`; then return 0; else return 1; fi
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