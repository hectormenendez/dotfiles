# Get directory, where the script files resides
SELF=${BASH_SOURCE[0]}
[[ -z `readlink $SELF` ]] && SELF=`dirname $SELF` || SELF=`readlink $SELF | xargs dirname`
export PROFILE_SELF=$SELF

# Include libs!
. "$SELF/inc/lib.sh"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set the creation mask, so files are created with 600 and dirs as 700
umask 077

# don't put duplicate lines in the history.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set color command prompt
export PS1='\[\033[01;34m\]\w\[\033[00m\]\$ '

# Force brew commands to be available before currently installed ones
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# set file colors
eval `gdircolors ~/.dir_colors`

# If an alias file exists, load it.
if [ -f ~/.alias ]; then source ~/.alias; fi

# These are for mac only
if ! $(isLinux); then

	# Make sure core-utils are installed
	if [[ ! -d /usr/local/Cellar/coreutils ]]; then
	    echo "coreutils were not found, please install them with Homebrew."
	fi

	# Make sure gnu-sed is installed
	if [[ -z $(ls /usr/local/Cellar/gnu-sed/*/bin/gsed 2> /dev/null) ]]; then
	    echo "gnu-sed was not found, please install it with Homebrew."
	fi

fi

# Prepend git branch name on command prompt.
if [ -r "$SELF/git/prompt.sh" ]; then source "$SELF/git/prompt.sh"; fi

# Make custom git commmand available
if [[ ! -L /usr/local/bin/isGIT ]]; then
    ln -s $SELF/git/isGIT.sh /usr/local/bin/isGIT
fi

# Enable VirtualEnvWrapper
if [[ ! -f /usr/local/bin/virtualenvwrapper.sh ]]; then
	echo "Please, install virtualenv and virtualenvwrapper"
	echo "https://gist.github.com/pithyless/1208841"
fi

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Ruby environment management.
eval "$(rbenv init -)"

if ! $(isLinux); then
	export GEM_HOME="$(brew --prefix)/opt/gems"
	export GEM_PATH="$(brew --prefix)/opt/gems"
	export RBENV_ROOT="$(brew --prefix rbenv)"
fi