#!/bin/bash

function isLinux {
    if [ "$(uname)" == "Darwin" ]; then
        return 1 # 1? false!, yup, this is false
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        return 0 # You guessed it, this is true
    else
        echo "The current OS is not supported"
        exit 1
    fi
}

function has {
    if `command -v $1 > /dev/null 2>&1`; then return 0; else return 1; fi
}

function dotfiles {
    # try first the unix way, then the bsd way. (brew might be already installed)
    {
        find $1 -maxdepth 1 -type f -name "*.sh" -exec basename {} ".sh" 2> /dev/null \;
    } || {
        find $1 -depth 1 -type f -name "*.sh" -exec basename {} ".sh" 2> /dev/null \;
    }
}

# make usr/local writable to everyone in the same group as current user
function perms {
    sudo -k chown -R $(id -u):$(id -g) /usr/local
    sudo -k chmod -R u+rw,g+rw,o-rwx /usr/local
}