#-------------------------------------------------------------------------------- General

if patched_font_in_use; then
    TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
    TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
    TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
    TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
else
    TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
    TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
    TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
    TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'235'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'255'}
TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}

export git_colour="124"
#------------------------------------------------------------------------------- Segments

TMUX_POWERLINE_SEG_PWD_MAX_LEN=33
TMUX_POWERLINE_DEFAULT_GITCOLOUR="251"

#----------------------------------------------------------------------------- StatusBars
# Format: segment, bg, fg, [sep]


if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then #------------------------------ Left
    TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
        "pwd            12    236" \
        "git-branch     25    251" \
        "vcs_compare    32    251" \
        "vcs_staged     2     238" \
        "vcs_modified   11    238" \
        "vcs_others     208   238" \
    )
fi

if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then #---------------------------- Right
    TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
        "tmux_session_info 25  251"\
        "hostname          12  236"\
    )
fi
