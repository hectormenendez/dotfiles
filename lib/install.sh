# Sources utils only if they are not already available
[[ ! $DOTFILES_UTILS ]] && source "${BASH_SOURCE%/*}/utils.sh"

isDarwin && source "$DOTFILES_LIB/install-osx.sh"
isArch   && source "$DOTFILES_LIB/install-arch.sh"

# Common installation steps
echo "Updating vim's plugin manager"
rm -Rf ~/.vim/autoload/plug.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim