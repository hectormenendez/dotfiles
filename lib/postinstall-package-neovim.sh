#!/usr/bin/env bash
set -e

[ ! isDarwin  ] && \
    echo "Warning: not available for this OS" && \
    exit 1

_path_vim=$DOTFILES_SRC/config/nvim

# python tools for neovim
pip3 install --upgrade neovim

# download the latest version of the plug manager
rm -Rf $_path_vim/autoload/plug.vim
curl -fLo $_path_vim/autoload/plug.vim \
    --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install Plug, Plugins, and quit
nvim +PlugInstall +UpdateRemotePlugins +qall
