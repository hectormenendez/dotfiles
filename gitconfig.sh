[user]
	name = Héctor Menéndez
	email = etor.mx@gmail.com

[core]
	whitespace=fix,-indent-with-non-tab,trailing-space,cr-at-eol
	editor = nano

[push]
	# 'git push' should only do the current branch, not all
	default = current

[advice]
	statushints = false

[apply]
	whitespace = strip

[alias]
	co = checkout
	st = status
	add  = add -v
	tagshow = !sh -c 'git rev-list $0 | head -n 1'
	logfile = !sh $PROFILE_SELF/git/logfile.sh

[color]
	ui = true

[color "branch"]
	current = yellow reverse
	local = green
	remote = blue

[color "diff"]
	whitespace = red reverse
	meta = yellow bold
	frag = magenta bold
	old = red bold
 	new = green bold

[color "status"]
	added = yellow
	changed = green
	untracked = cyan

[difftool "sourcetree"]
	cmd = opendiff \"$LOCAL\" \"$REMOTE\"
	path =

[mergetool "sourcetree"]
	cmd = /Applications/SourceTree.app/Contents/Resources/opendiff-w.sh \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\"
	trustExitCode = true
