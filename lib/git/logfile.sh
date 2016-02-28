#/bin/bash

################################################################################
#   GIT LOG File                                                               #
#   Written by: Hector Menendez <h@cun.mx> @et0r on Twitter.                   #
#   2011/AUG/25 05:25                                                          #
#                                                                              #
#   You are free to use and/or modify this file as long as                     #
#   you contact me and give some feedback. Or maybe, just say Hi!              #
#                                                                              #
#   Cheers mate!                                                               #
################################################################################


# does amI exist?
#hash isGIT 2>&- || { echo >&2 "isGIT not found; Aborting."; exit 1; }

# are we in a repo?
if ! isGIT; then
    echo >&2 "You need to be inside a git repository; Aborting."
    exit
fi

colors=true

# I want the --no-color argument to be positioned anywhere
# on the argument list, so...

# check if there's a color declaration.
for arg in $@; do
    if [ "$arg" = "--no-color" -o "$arg" = '-C' ]; then
        colors=false
        break;
    fi
done

# if color argument found remove it from argument list
if ! $colors; then arg=`echo $@ | sed "s/$arg//"`; fi

# parse remaining arguments
for arg in $arg; do
case $arg in
#################################################################### set filters

-a | --added    ) filter="--diff-filter=A" ;;
-c | --copied   ) filter="--diff-filter=C" ;;
-d | --deleted  ) filter="--diff-filter=D" ;;
-m | --modified ) filter="--diff-filter=M" ;;
-r | --renamed  ) filter="--diff-filter=R" ;;
-t | --changed  ) filter="--diff-filter=T" ;;
-u | --unmerged ) filter="--diff-filter=U" ;;
-x | --unknown  ) filter="--diff-filter=X" ;;
-b | --broken   ) filter="--diff-filter=B" ;;

################################################################### show command
                                                                      -\? | \? )
echo '
git log --name-only --abbrev-commit --diff-filter={FILTER} | grep -Pv "^(?=\s)"
'
exit 0;;


##################################################################### show usage
                                                                              *)
echo "
GIT Log file filter.

Author: Hector Menéndez <h@cun.mx>
        2011/AUG/24 23:37

This is just a wrapper for a long git command, it wraps 'git log'.

Removes commit messages, and retrieves commits names in their short version.

...That's ... about ... it.

Available filters:

  -a | --added
  -c | --copied
  -d | --deleted
  -m | --modified
  -r | --renamed
  -t | --changed
  -u | --unmerged
  -x | --unknown
  -b | --broken

Extra Parameters:

  -C | --no-color       Don't use colors. [Must be specified first]
  -? | --show           Shows the command used for this filtering.

Example:

git logfile -d
"
exit 1
################################################################################
esac
done

if $colors; then
  cONE=`echo "\033[1;33m"`
  cTWO=`echo "\033[1;30m"`
  cTRI=`echo "\033[1;32m"`
  cNON=`echo "\033[0m"`

  git log --name-only --abbrev-commit $filter | grep -Pv "^(?=\s)" | \
    gsed -E "s/commit (.*)/\n\n$cONE\1$cNON/g"                     | \
    gsed -E "s/^(Author:)(.*)/$cTWO\1$cNON\2/g"                    | \
    gsed -E "s/^(Date:)(.*)/$cTWO\1$cNON\2\n$cTRI/g"
else
  git log --name-only --abbrev-commit $filter | grep -Pv "^(?=\s)" ;
fi
