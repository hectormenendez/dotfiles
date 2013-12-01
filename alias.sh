# Sudo should be sudo
alias sudo='sudo '

# Override boring OS.X commands with GNU's
alias echo='gecho'
alias sed='gsed'

# Show ls in a pretty way (depends on brew's coreutils)
alias ls='gls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable --group-directories-first'

# Show Color on grep
alias grep='grep --color=auto'

# SublimeText
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# Erase the screen and show the file listing.
alias c="clear && ls -lA"
