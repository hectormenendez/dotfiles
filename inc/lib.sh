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
    local depth='depth'
    if $(isLinux); then depth="max$depth"; fi
    echo `find $1 -$depth 1 -type f -name '*.sh' -exec basename {} .sh \;`
}