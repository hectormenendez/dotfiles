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
PS1='\[\033[01;34m\]\w\[\033[00m\]\$ '

# set file colors
eval `gdircolors ~/.dir_colors`

# If an alias file exists, load it.
if [ -f ~/.alias ]; then source ~/.alias; fi

