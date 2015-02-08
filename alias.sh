# Include libs!
. "$SELF/inc/lib.sh"

# Sudo should be sudo
alias sudo='sudo '

# Show Color on grep
alias grep='grep --color=auto'

# Erase the screen and show the file listing.
alias c="clear && ls -lA"

LS="ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable --group-directories-first"
alias ls=$LS

# These are for mac only
if ! $(isLinux); then

	# Override boring OS.X commands with GNU's
	alias dircolors='gdircolors'
	alias echo='gecho'
	alias sed='gsed'

	# Show ls in a pretty way (depends on brew's coreutils)
	alias ls="g$LS"

	# SublimeText
	alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

fi

