
# Source lib to get the function get_tmux_pwd
source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

branch_symbol=""
git_colour="238"
svn_colour="220"
hg_colour="45"

[ ! -z "${TMUX_POWERLINE_DEFAULT_GITSYMBOL}" ] && branch_symbol=${TMUX_POWERLINE_DEFAULT_GITSYMBOL}
[ ! -z "${TMUX_POWERLINE_DEFAULT_GITCOLOUR}" ] && git_colour=${TMUX_POWERLINE_DEFAULT_GITCOLOUR}

run_segment() {
	tmux_path=$(get_tmux_cwd)
	cd "$tmux_path"
	branch=""
	if [ -n "${git_branch=$(__parse_git_branch)}" ]; then
		branch="$git_branch"
	fi

	if [ -n "$branch" ]; then
		echo "${branch}"
	fi
	return 0
}


# Show git banch.
__parse_git_branch() {
	type git >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

	#git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'

	# Quit if this is not a Git repo.
	branch=$(git symbolic-ref HEAD 2> /dev/null)
	if [[ -z $branch ]] ; then
		# attempt to get short-sha-name
		branch=":$(git rev-parse --short HEAD 2> /dev/null)"
	fi
	if [ "$?" -ne 0 ]; then
		# this must not be a git repo
		return
	fi

	# Clean off unnecessary information.
	branch=${branch##*/}

	echo  -n "#[fg=colour${git_colour}]${branch_symbol} #[fg=colour${TMUX_POWERLINE_CUR_SEGMENT_FG}]${branch}"
}

