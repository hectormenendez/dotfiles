# Get directory, where the script files resides
SELF=${BASH_SOURCE[0]}
[[ -z `readlink $SELF` ]] && SELF=`dirname $SELF` || SELF=`readlink $SELF | xargs dirname`

# Include libs!
. "$SELF/inc/lib.sh"

# Environment variables
if ! $(isLinux); then
	export LC_ALL=en_US.UTF-8
	export LANG=en_US.UTF-8
fi
export DOTFILES=$SELF

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Initialise Path so it uses /usr/local/bin first.
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# If an alias file exists, load it.
if [ -f ~/.alias ]; then source ~/.alias; fi

# Only valid for Bash4: wildcard ** now means recursive
shopt -s globstar

# Set the creation mask, so files are created with 600 and dirs as 700
umask 077

# History management:
# cleanup the history file, by manually removing dups
tac $HISTFILE | awk '!x[$0]++' | tac | sponge $HISTFILE

# don't put duplicate lines in the history and erase those that already exist
# don't overwrite history on login, append to it.
HISTCONTROL=erasedups:ignorespace
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set color command prompt
export PS1='\[\033[01;30m\]\h \[\033[01;34m\]\w\[\033[00m\]\n\$ '

# set file colors
eval `dircolors ~/.dir_colors`

# Prepend git branch name on command prompt.
if [ -r "$SELF/git/prompt.sh" ]; then source "$SELF/git/prompt.sh"; fi