# Sources utils only if they are not already available
[[ ! $DOTFILES_UTILS ]] && source "${BASH_SOURCE%/*}/utils.sh"

# Run this only on mac
[ ! isArch ] && exit 1

echo "Updating system and installing dependencies…"
deps=(
	'moreutils'
	'dnsutils'
	'python'
	'ruby'
	'git'
    'neovim'
	'tmux'
    'fzf'
    'the_silver_searcher'
)
sudo pacman -Syu --noconfirm ${deps[@]}

if [ ! -d  ~/.nvm ]; then 
    echo "Installing NVM"
    git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`
fi

echo "Renaming .profile"
mv ~/.profile ~/.bash_profile

export NVM_DIR=$HOME/.nvm
source "$NVM_DIR/nvm.sh"
