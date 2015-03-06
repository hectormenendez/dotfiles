# Get directory, where the script files resides
SELF=${BASH_SOURCE[0]}
[[ -z `readlink $SELF` ]] && SELF=`dirname $SELF` || SELF=`readlink $SELF | xargs dirname`
export PROFILE_SELF=$SELF

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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
export PS1='\[\033[01;30m\]\h \[\033[01;34m\]\w\[\033[00m\]\$ '

# Force brew commands to be available before currently installed ones
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

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
		binaries=(
			bash
			python
			node
			tree
			ack
			git
		)
		brew install ${binaries[@]}
		echo "Making Bash4 default..."
		sudo mv /bin/bash /bin/bash3
		sudo ln -s /usr/local/bin/bash /bin/bash
	fi

	# Make sure core-utils are installed
	if [[ ! -d $(brew --prefix)/Cellar/coreutils ]]; then
		echo "CoreUtils was not found… making an install"
		base=(
			coreutils
			findutils
			gnu-tar
			gnu-sed
			gnu-indent
		)
		brew install ${base[@]} --with-default-names
		brew tap homebrew/dupes; brew install grep --with-default-names
	fi
	export PATH=$(brew --prefix coreutils)/libexec/gnubin:$HOME/.nodebrew/current/bin:$PATH
	brew cleanup  > /dev/null 2>&1
	brew prune  > /dev/null 2>&1
fi

# Only valid for Bash4: wildcard ** now means recursive
shopt -s globstar

# Prepend git branch name on command prompt.
if [ -r "$SELF/git/prompt.sh" ]; then source "$SELF/git/prompt.sh"; fi

# Make custom git commmand available
if [[ ! -L /usr/local/bin/isGIT ]]; then
    ln -s $SELF/git/isGIT.sh /usr/local/bin/isGIT
fi

if $(has python); then

	# Enable VirtualEnvWrapper
	if ! $(has virtualenv); then
		echo "Virtualenv was not found, installing it ..."
		pip install --upgrade setuptools
		pip install --upgrade pip
		pip install virtualenv
		pip install virtualenvwrapper
	fi
	export WORKON_HOME=$HOME/.virtualenvs
	source $(brew --prefix)/bin/virtualenvwrapper.sh

fi

# Ruby environment management.
if $(has ruby); then
	rbenv_installed=false
	if ! $(has rbenv); then
		echo "Rbenv was not found, installing it ..."
		brew install rbenv ruby-build
		rbenv_installed=true
	fi
	if ! $(isLinux); then
		export GEM_HOME=$(brew --prefix)/opt/gems
		export GEM_PATH=$(brew --prefix)/opt/gems
		export RBENV_ROOT=$(brew --prefix rbenv)
		export PATH=$GEM_PATH/bin:$PATH
	fi
	eval "$(rbenv init -)"
	if [[ ${rbenv_installed} == true || $(rbenv global) == 'system' ]]; then
		echo "Installing latest version of ruby."
		rbenv_ver=$(rbenv install --list | grep -P '^\s*\d+\.\d+\.\d+$' | tail -n1 | xargs)
		rbenv install $rbenv_ver
		rbenv global $rbenv_ver
	fi
	rbenv shell $(rbenv global)
	rbenv rehash
fi
