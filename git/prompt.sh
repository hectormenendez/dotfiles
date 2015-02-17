################################################################################
#   GIT branch-prompt
#   Written by: Héctor Menéndez <h@cun.mx>                                     #
#   2011/AUG/25 16:00                                                          #
#                                                                              #
#   You are free to use and/or modify this file as long as                     #
#   you contact me and give some feedback. Or maybe, just say Hi!              #
#                                                                              #
#   Cheers mate!                                                               #
#                                                                              #
#   Usage:                                                                     #
#                                                                              #
#   Just add at the end of your ~/.profile                                     #
#                                                                              #
#   if [ -r "$HOME/path/to/git-branch-prompt.sh" ]; then                       #
#       source "$HOME/path/to/git-branch-prompt.sh"                            #
#   fi                                                                         #
#                                                                              #
#   And then select the style that you feel more comfortable with.             #
#                                                                              #
#   Note: The front version has a "bug" [it really isn't] that removes the     #
#         prompt if you hit backspace more times than actually written.        #
#         This is normal, since the prompt is actually empty,                  #
#                                                                              #
################################################################################

### SET STYLE HERE #############################################################

    git_branch="back"

################################################################################

function git_branch_front () {

    local cform="\033[01;1m"  # 1m = bold; 7m = inverted colors.
    local cnorm="\033[01;37m" # white
    local cgitb="\033[01;36m" # cyan
    local cpath="\033[01;34m" # blue
    local cuser="\033[01;32m" # green
    local crset="\033[01;0m"
    local branch=`git branch --no-color 2>/dev/null | grep "\*" --color=none | sed 's/^\*\s*/:/'`
    local pwd=${PWD/"$HOME"/\~/}
    # dont' know why the first slash is not being replaced
    # so I used sed, to get rid of it.
    pwd=`echo $pwd | sed 's%/%%'`
    local prompt=$cform$cuser${USER}@${HOSTNAME%%.*}$cnorm:$cpath$pwd$cgitb$branch$crset"\$ "
    echo -ne $prompt
}

function git_branch_back (){
    local cgitb="\033[01;36m" # cyan
    local crset="\033[01;0m"  # reset
    local branch=`git branch --no-color 2>/dev/null | grep "\*" --color=none | sed 's/^\*\s*//'`
    if [ "$branch" != "" ]; then
        echo -ne "$cgitb$branch » $crset"
    fi
}

if [ "$git_branch" = "front" ]; then
    # completely replace the command prompt
    PROMPT_COMMAND="git_branch_front"
    PS1=""
elif [ "$git_branch" = "back" ]; then
    # just prepend branch name
    PROMPT_COMMAND="git_branch_back"
fi
