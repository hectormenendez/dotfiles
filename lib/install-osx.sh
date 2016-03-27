# Sources utils only if they are not already available
[[ ! $DOTFILES_UTILS ]] && source "${BASH_SOURCE%/*}/utils.sh"

# Run this only on mac
[ ! isDarwin ] && exit 1

hadBrew=true
if [[ -z $(which brew) ]]; then
    hadBrew=false
    echo "Installing brew…"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap homebrew/completions # Install brew completions
    brew tap homebrew/dupes       # Allow duplications of OS.X software
    brew install coreutils caskroom/cask/brew-cask
fi

COMMANDS=(
    'binutils'
    'findutils'
    'diffutils'
    'moreutils  --with-default-names'
    'gnu-tar    --with-default-names'
    'gnu-sed    --with-default-names'
    'gnu-which  --with-default-names'
    'gnu-indent --with-default-names'
    'grep       --with-default-names'
    'ed         --with-default-names'
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
    'tmux'
    'reattach-to-user-namespace'
    'fzf'
    'the_silver_searcher'
)

didInstall=false
for (( i=0; i < ${#COMMANDS[@]}; i++ )); do
    CMD=${COMMANDS[$i]}
    CMD=(${CMD// / }) # split string into array by spaces

    # omit those packages that already exist
    test -d $(brew --prefix ${CMD[0]}) && continue
    echo "Installing ${CMD[0]}!"
    brew install ${CMD[0]} ${CMD[1]}
    didInstall=true

    # To properly install bash it has to be replaced
    [ ${CMD[0]} = 'bash' ] && brew link --overwrite bash

    # Properly configure python
    if [ ${CMD[0]} = 'python3' ]; then
        brew linkapps python3
        pip install --upgrade pip setuptools neovim
    fi
done

if [ "$didInstall" = true ]; then
    echo "Cleaning up the house…"
    brew cleanup
    brew prune
else
    echo "Every brew package was already installed."
fi

# Make sure nvm is available
source $(brew --prefix nvm)/nvm.sh
