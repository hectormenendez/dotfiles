#!/usr/bin/env bash
set -e

[ ! isDarwin  ] && \
    echo "Warning: not available for this OS" && \
    exit 1

_path="$(brew --prefix)/bin/bash"

brew link --overwrite bash
sudo sh -c "echo $_path >> /etc/shells"
chsh -s $_path
