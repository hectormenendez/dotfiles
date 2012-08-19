# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

alias sudo='sudo '
alias ls='gls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable --group-directories-first'
alias grep='grep --color=auto'

