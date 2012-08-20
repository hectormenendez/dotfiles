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
