# Include utils!
source "$SELF/lib/utils.sh"

# Sudo should be sudo
alias sudo='sudo '

# Show Color on grep
alias grep='grep --color=auto'

# Erase the screen and show the file listing.
alias c="clear && ls -lA"

LS="ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable --group-directories-first"
alias ls=$LS

alias isGIT="git status >/dev/null 2>/dev/null"


# These are for mac only
if ! $(isLinux); then

	# Override boring OS.X commands with GNU's
	alias dircolors='gdircolors'

	# Show ls in a pretty way (depends on brew's coreutils)
	alias ls="g$LS"
	alias tac="gtac"

	# SublimeText
	alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

fi

