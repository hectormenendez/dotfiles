#!/usr/bin/env bash
set -e

# TODO: make package and cask installation a single function

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

    # Enable Yamamoto's Emacs fork
    brew tap railwaycat/emacsmacport

    # trigger installation of cask and services
    brew cask &> /dev/null
    brew services &> /dev/null
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
    'emacs' # terminal version
    'emacs-mac' # Yamamoto's GUI version
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
    'synergy'
    'launchcontrol'
    # communication
    'whatsapp'
    'slack-beta'
    # devtools
    'emacs'
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

    # if available run post-install script.
    [ -f "$DOTFILES_LIB/postinstall-package-$_pkg.sh" ] && \
        source "$DOTFILES_LIB/postinstall-package-$_pkg.sh"
done

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
