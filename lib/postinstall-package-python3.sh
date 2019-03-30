#!/usr/bin/env bash
set -e

[ ! isDarwin  ] && \
    echo "Warning: not available for this OS" && \
    exit 1

# make sure we have the latest version for setuptools
pip3 install --upgrade pip setuptools wheel
