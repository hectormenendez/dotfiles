# Get directory, where the script files resides
SELF=${BASH_SOURCE[0]}
[[ -z `readlink $SELF` ]] && SELF=`dirname $SELF` || SELF=`readlink $SELF | xargs dirname`
export PROFILE_SELF=$SELF

# Include libs!
. "$SELF/inc/lib.sh"

# Only valid for Bash4 (remember to install it)
# wildcard ** now means recursive
shopt -s globstar

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

# make usr/local writable to everyone in the same group as current user
sudo -k chown -R $(id -u):$(id -g) /usr/local
sudo -k chmod -R u+rw,g+rw,o-rwx /usr/local

# set color command prompt
export PS1='\[\033[01;30m\]\h \[\033[01;34m\]\w\[\033[00m\]\$ '

# Force brew commands to be available before currently installed ones
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# If an alias file exists, load it.
if [ -f ~/.alias ]; then source ~/.alias; fi

# set file colors
eval `dircolors ~/.dir_colors`


# These are for mac only
if ! $(isLinux); then

	# Brew must be installed.
	if test ! $(which brew); then
		echo "Installing brew…"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	echo "Updating brew…"
	brew update

	# Make sure core-utils are installed
	if [[ ! -d /usr/local/Cellar/coreutils ]]; then
		echo "CoreUtils was not found… making an install"
		brew install coreutils
		brew install findutils
		binaries=(
			bash
			python
			node
			tree
			ack
			git
		)
		brew install ${binaries[@]}
		sudo mv /bin/bash /bin/bash3
		sudo ln -s /usr/local/bin/bash /bin/bash
	fi

	export PATH=$(brew --prefix coreutils)/libexec/gnubin:/usr/local/sbin:$PATH
	export NODEBREW_ROOT=/usr/local/var/nodebrew
	brew cleanup
	brew prune
fi

# Prepend git branch name on command prompt.
if [ -r "$SELF/git/prompt.sh" ]; then source "$SELF/git/prompt.sh"; fi

# Make custom git commmand available
if [[ ! -L /usr/local/bin/isGIT ]]; then
    ln -s $SELF/git/isGIT.sh /usr/local/bin/isGIT
fi

if $(has python); then

	# Enable VirtualEnvWrapper
	if [[ ! -f /usr/local/bin/virtualenvwrapper.sh ]]; then
		echo
		echo "Please, install virtualenv and virtualenvwrapper"
		if ! $(isLinux); then echo "https://gist.github.com/pithyless/1208841"; fi
		echo
	else
		export WORKON_HOME=$HOME/.virtualenvs
		source /usr/local/bin/virtualenvwrapper.sh
	fi

fi

if $(has ruby); then

	if ! $(has rbenv); then
		echo
		echo "Please, install rbenv."
		echo
	else
		# Ruby environment management.
		eval "$(rbenv init -)"

		if ! $(isLinux); then
			export GEM_HOME="$(brew --prefix)/opt/gems"
			export GEM_PATH="$(brew --prefix)/opt/gems"
			export RBENV_ROOT="$(brew --prefix rbenv)"
		fi
	fi
fi