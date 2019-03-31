#!/usr/bin/env bash
set -e

[ ! isDarwin  ] && \
    echo "Warning: not available for this OS" && \
    exit 1

# make sure emacs is linked for the operating system
brew link emacs
