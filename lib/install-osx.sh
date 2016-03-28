# Sources utils only if they are not already available
[[ ! $DOTFILES_UTILS ]] && source "${BASH_SOURCE%/*}/utils.sh"

# Run this only on mac
[ ! isDarwin ] && exit 1

hadBrew=true
if [[ -z $(which brew) ]]; then
    hadBrew=false
    echo "Installing brew…"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    /usr/local/bin/brew install coreutils
    # after coreutils are installed, try to continue installation… try.
    cd ~
    source .profile

    brew tap homebrew/completions # for brew completions
    brew tap homebrew/dupes       # duplications for OS.X software

    # Install OS.X apps from brew
    brew install caskroom/cask/brew-cask
    # Install tmux with forced support for truecolor
    brew tap choppsv1/term24
    brew install choppsv1/term24/tmux
    # Use development version of neovim
    brew tap neovim/neovim
    brew install --HEAD neovim
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
