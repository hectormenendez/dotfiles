
# These are for mac only
if ! $(isLinux); then
	hadBrew=true
	# Brew must be installed.
	if ! $(which brew); then
		hadBrew=false
		echo "Installing brew…"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	# Make sure core-utils are installed
	if [[ ! -d $(brew --prefix)/Cellar/coreutils ]]; then
		echo "CoreUtils was not found… making an install"
		base=(
			coreutils
			findutils
			moreutils
			gnu-tar
			gnu-sed
			gnu-indent
		)
		brew install ${base[@]} --with-default-names
		brew tap homebrew/dupes; brew install grep --with-default-names
	fi

	echo "Installing dependencies…"
	deps=(
		bash
		python
		node
		nodebrew
		tree
		ack
		git
	)
	brew install ${deps[@]}
	nodebrew install-binary latest
	nodebrew use latest

	echo "Making Bash4 the default shell…"
	chsh -s /usr/local/bin/bash

	echo "Cleaning up the house…"
	brew cleanup  > /dev/null 2>&1
	brew prune  > /dev/null 2>&1

# is this ArchLinux? PacMan baby!
elif [ -f "/etc/arch-release" ]; then

	echo "Updating system and installing dependencies…"
	deps=(
		base-devel
		moreutils
		python
		python-virtualenv
		ruby
		git
	)
	sudo pacman -Syu --noconfirm ${deps[@]}
fi