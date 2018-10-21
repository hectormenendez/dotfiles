#!/usr/bin/env bash
set -e

# Run this only on arch linux
[ ! isArch ] && echo "This script is only compatible with ArchLinux." && exit 1

echo "Updating system and installing dependencies…"
sudo pacman -Syuu --noconfirm

if $(pacman -Qi yay &> /dev/null); then
    echo "Skipping, alreadt installation."
else
    echo "Installing AUR Manager."
    mkdir -p ~/Source/external
    git clone https://aur.archlinux.org/yay.git ~/Source/external/yay
    cd ~/Source/external/yay
    makepkg -si
fi

_packages=(
    'moreutils'
    'dnsutils'
    'ruby'
    'python'
    'python-pip'
    'python-setuptools'
    'pyenv'
    'pyenv-virtualenv'
    'git'
    'fzf'
    'the_silver_searcher'
    'exa' # coloring ls
    'neovim'
    'emacs'
    'ttf-iosevka' # programming font
)
for (( _i=0; _i < ${#_packages[@]}; _i++ )); do
    read -r -a _arg <<< "${_packages[$_i]}"
    _pkg=${_arg[0]}
    _arg=("${_arg[@]:1}") # Shift array

    inCSV $_force "packages" && _force="$_force,$pkg"
    inCSV $_skip "packages" && _skip="$_skip,$_pkg"

    inCSV $_skip $_pkg && continue

    if inCSV $_force $_pkg; then
        # force was passed for this package uninstall it so it can be reinstalled
        yay -Qi $_pkg &> /dev/null && yay -Rcsn --noconfirm $_pkg;
    else
        # if package exists go to the next one.
        yay -Qi $_pkg &> /dev/null &&\
            echo "Skipping, already installed: $_pkg" &&\
            continue
    fi
    # do install package
    yay -S --noconfirm $_pkg ${_arg[@]}

    [ $_pkg = 'python-pip' ] && sudo pip install --upgrade wheel

    if [ $_pkg = 'neovim' ]; then
        sudo pip install --upgrade neovim
        _pathvim=~/.config/nvim
        rm -Rf $_pathvim
        git clone https://github.com/hectormenendez/vimrc $_pathvim
        rm -Rf $_pathvim/autoload/plug.vim
        curl -fLo $_pathvim/autoload/plug.vim \
             --create-dirs \
             https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        nvim +PlugInstall +UpdateRemotePlugins +qall
    fi

    if [ $_pkg = 'emacs' ]; then
        _pathemacs=~/.config/emacs.d
        rm -Rf $_pathemacs
        git clone https://github.com/hectormenendez/emacs.d $_pathemacs
        git clone https://github.com/hectormenendez/emacs.theme $_pathemacs/_themes
        ln -s $_pathemacs ~/.emacs.d
    fi
done

if [ -f ~/.profile ]; then
    echo "Renaming .profile"
    mv ~/.profile ~/.bash_profile
fi

if [ ! -d ~/.rvm ]; then
    echo "Installing rvm"
    curl -sSL https://get.rvm.io | bash -s stable
fi

if [ ! -d  ~/.nvm ]; then
    echo "Installing NVM"
    git clone https://github.com/creationix/nvm.git ~/.nvm &&\
    cd ~/.nvm &&\
    git checkout `git describe --abbrev=0 --tags` &&\
    source ~/.nvm/nvm.sh &&\
    nvm install --lts --latest-npm
fi
