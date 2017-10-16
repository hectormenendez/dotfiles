#!/usr/bin/env bash
set -e

# Run this only on mac
[ ! isDarwin ] && echo "This script is only compatible with Darwin." && exit 1

if [[ $(inCSV $_skip 'brew') ]]; then
    if [[ -z $(which brew) ]]; then
        hadBrew=false
        echo "Installing brew…"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        brew tap | grep -v "homebrew/core" | xargs -I {} brew untap {}
        brew tap --list-official | xargs -I {} brew tap {}
        brew cleanup
        brew prune
        brew upgrade
    fi
    brew tap railwaycat/emacsmacport # OS.X Emacs
    brew tap neovim/neovim # better neovim
    brew tap caskroom/cask
fi

_packages=(
    'coreutils'
    'binutils'
    'findutils'
    'diffutils'
    'moreutils --with-default-names'
    'gnu-tar --with-default-names'
    'gnu-sed --with-default-names'
    'gnu-which --with-default-names'
    'gnu-indent -with-default-names'
    'grep --with-default-names'
    'ed --with-default-names'
    'gnutls'
    'gawk'
    'gzip'
    'screen'
    'watch'
    'wdiff --with-gettext'
    'wget'
    'gnupg'
    'gnupg2'
    'bash'
    'bash-completion'
    'nano'
    # Non GNU utils
    'nvm'
    'file-formula'
    'git'
    'less'
    'openssh'
    'rsync'
    'unzip'
    'vim --override-system-vi'
    'python3'
    'fzf'
    'the_silver_searcher'
    'ccat'
    'neovim --HEAD'
)

for (( _i=0; _i < ${#_packages[@]}; _i++ )); do
    read -r -a _arg <<< "${_packages[$_i]}"
    _pkg=${_arg[0]}
    _arg=("${_arg[@]:1}") # Shift array

    inCSV $_force "packages" && _force="$_force,$pkg"
    inCSV $_skip "packages" && _skip="$_skip,$_pkg"

    inCSV $_skip $_pkg && continue

    if inCSV $_force $_pkg; then
        # force was passed for this package, uninstall it so it can be reinstalled
        brew ls --version $_pkg &> /dev/null && brew uninstall $_pkg
    else
        # if package exist go to the next one
        brew ls --versions $_pkg &> /dev/null && \
            echo "Skipping, already installed: $_pkg" && \
            continue
    fi

    # install
    brew install $_pkg ${_arg[@]}

    [ $_pkg = 'bash' ] && brew link --overwrite bash

    [ $_pkg = 'neovim' ] && \
        pip3 install --upgrade neovim && \
        rm -Rf ~/.vim/autoload/plug.vim && \
        curl -fLo ~/.vim/autoload/plug.vim \
            --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
        nvim +PlugInstall +UpdateRemotePlugins +qall

    [ $_pkg = 'python3' ] && \
        pip3 install --upgrade pip setuptools wheel
done

# Enabling truecolor and italics on both tmux and iterm
tic -x $DOTFILES_LIB/256color-iterm.terminfo
