#!/usr/bin/env bash
set -e

[ ! isDarwin  ] && \
    echo "Warning: not available for this OS" && \
    exit 1

_src=$(brew --prefix emacs-mac)/Emacs.app
_dst=/Applications

# make sure emacs is linked for the operating system
osascript -e \
    'tell application "Finder" to make alias file to POSIX file "'$_src'" at POSIX file "'$_dst'"'
