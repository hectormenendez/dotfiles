# Sources utils only if they are not already available
[[ ! $DOTFILES_UTILS ]] && source "${BASH_SOURCE%/*}/utils.sh"

# Run this only on mac
[ ! isArch ] && exit 1

echo "Updating system and installing dependencies…"
deps=(
	'moreutils'
	'dnsutils'
	'sponge'
	'python'
	'ruby'
	'git'
)
sudo pacman -Syu --noconfirm ${deps[@]}

echo "Installing NVM"
git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`

echo "Renaming .profile"
mv ~/.profile ~/.bash_profile