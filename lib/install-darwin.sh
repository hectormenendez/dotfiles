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
    fi
    # Remove all taps, to start from scratch.
    brew tap | grep -v "homebrew/core" | xargs -I {} brew untap {} || echo "Nothing to untap"
    brew cleanup
    brew update
    brew upgrade

    # Enable Yamamoto's Emacs fork
    brew tap railwaycat/emacsmacport
    brew tap homebrew/cask-versions

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
    'mas' # allows installing apps from the terminal
    'mosh' # enable sshing to terminal with persistent connection
    'jenv'
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
    'neovim'
    'exa'
    'pyenv'
    'pyenv-virtualenv'
)

_casks=(
    # utils
    'iterm2'
    'vlc'
    'google-chrome'
    'google-chrome-canary'
    'fantastical'
    'adobe-creative-cloud'
    'adobe-creative-cloud-cleaner-tool'
    'keepingyouawake'
    'spectacle'
    'appcleaner'
    'synergy'
    'launchcontrol'
    'disablemonitor'
    '1password-beta'
    'nordvpn'
    'boostnote'
    'insync'
    'karabiner-elements'
    # streaming
    'audio-hijack'
    'obs'
    'loopback'
    # communication
    'whatsapp'
    'slack-beta'
    # devtools
    'emacs'
    'visual-studio-code-insiders'
    'gitkraken'
    'chromedriver'
    'rescuetime'
    'docker'
    # entertainment
    'spotify'
)

_apps=(
    '585829637' # Todoist
    '411643860' # Daisy Disk
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

for (( _i=0; _i < ${#_apps[@]}; _i++ )); do
    read -r -a _arg <<< "${_apps[$_i]}"
    _app=${_arg[0]}
    _arg=("${_arg[@]:1}") # Shift array

    inCSV $_force "apps" && _force="$_force,$_app"
    inCSV $_skip "apps" && _skip="$_skip,$_app"

    inCSV $_skip $_app && continue

    # TODO: make validation to uninstall first and then reinstall apps like in casks
    # install
    mas install $_app ${_arg[@]}
done

# Enabling truecolor and italics on both tmux and iterm
tic -x $DOTFILES_LIB/256color-iterm.terminfo
