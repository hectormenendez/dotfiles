#!/usr/bin/env bash
set -e

# TODO: make package and cask installation a single function
# TODO: Instead of running commands after package installation, check for script with name

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
    'moreutils'
    'gnu-tar'
    'gnu-sed'
    'gnu-which'
    'gnu-indent'
    'grep'
    'ed'
    'gnutls'
    'gawk'
    'gzip'
    'screen'
    'watch'
    'wdiff'
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
    'vim'
    'python3'
    'fzf'
    'the_silver_searcher'
    'ccat'
    'neovim --HEAD'
    'exa'
    'pyenv'
    'pyenv-virtualenv'
)

_casks=(
    'iterm2'
    'google-chrome'
    'google-chrome-canary'
    # utils
    'spectacle'
    'appcleaner'
    # communication
    'whatsapp'
    'slack-beta'
    # devtools
    'visual-studio-code-insiders'
    'chromedriver'
    # entertainment
    'spotify'
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
        brew ls --versions $_pkg &> /dev/null && brew uninstall $_pkg
    else
        # if package exist go to the next one
        brew ls --versions $_pkg &> /dev/null && \
            echo "Skipping, already installed: $_pkg" && \
            continue
    fi

    # install
    brew install $_pkg ${_arg[@]}

    [ $_pkg = 'bash' ] && brew link --overwrite bash

    if [ $_pkg = 'neovim' ]; then
        _path_vim=$DOTFILES_SRC/config/nvim
        pip3 install --upgrade neovim
        rm -Rf $_path_vim/autoload/plug.vim
        curl -fLo $_path_vim/autoload/plug.vim \
            --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        nvim +PlugInstall +UpdateRemotePlugins +qall
    fi

    [ $_pkg = 'python3' ] && \
        pip3 install --upgrade pip setuptools wheel

    # install the latest nvm LTS version
    if [ $_pkg = 'nvm'  ]; then
        _path_nvm_home="$HOME/.nvm"
        _path_nvm_opt="$(brew --prefix nvm)"
        [ ! -d $_path_nvm_home ] && mkdir $_path_nvm_home
        source "$_path_nvm_opt/nvm.sh"
        _nvm_ver=$(nvm ls-remote | grep "Latest LTS" | tail -n 1 | xargs | cut -d " " -f1)
        nvm install $_nvm_ver
        nvm use default node
    fi
done

# trigger cask install
# TODO: check for cask instead
brew cask > /dev/null
for (( _i=0; _i < ${#_casks[@]}; _i++ )); do
    read -r -a _arg <<< "${_casks[$_i]}"
    _csk=${_arg[0]}
    _arg=("${_arg[@]:1}") # Shift array

    inCSV $_force "casks" && _force="$_force,$_csk"
    inCSV $_skip "casks" && _skip="$_skip,$_csk"

    inCSV $_skip $_csk && continue

    if inCSV $_force $_csk; then
        # force was passed for this package, uninstall it so it can be reinstalled
        brew cask ls --versions $_csk &> /dev/null && brew cask uninstall $_csk
    else
        # if package exist go to the next one
        brew cask ls --versions $_csk &> /dev/null && \
            echo "Skipping, Cask already installed: $_csk" && \
            continue
    fi
    # install
    brew cask install $_csk ${_arg[@]}
done

# Enabling truecolor and italics on both tmux and iterm
tic -x $DOTFILES_LIB/256color-iterm.terminfo
