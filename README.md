# Hector Menendez's DotFiles

Not much going on here, just a place where to store my dotfiles.


* Make sure you have installed Homebrew and coreutils.

## Usage:

Just create symlinks in your $HOME


# GIT scripts

Nothing fancy, just a few scripts I use to spice things up in GIT.

### GIT branch-prompt
##### 2011/AUG/25 16:00

Automagically adds the current branch on git repos.


### GIT Log file filter.
##### 2011/AUG/24 23:37

This is just a wrapper for a long git command, it wraps 'git log'.

Removes commit messages, and retrieves commits names in their short version.

...That's ... about ... it.

#### Available filters:

    -a | --added
    -c | --copied
    -d | --deleted
    -m | --modified
    -r | --renamed
    -t | --changed
    -u | --unmerged
    -x | --unknown
    -b | --broken

#### Extra Parameters:

    -C | --no-color       Don't use colors. [Must be specified first]
    -? | --show           Shows the command used for this filtering.

#### Example:

    git logfile -d

### isGIT

Script helper, checks if current dir is actually a git repo.

### Usage:

    if isGIT; then
      do stuff
    else
      don't do stuff
    fi
