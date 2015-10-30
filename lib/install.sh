
# These are for mac only
if ! $(isLinux); then
	hadBrew=true
	# Brew must be installed.
	if ! $(which brew); then
		hadBrew=false
		echo "Installing brew…"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		brew tap homebrew/completions
		brew tap homebrew/dupes
	fi

	# Make sure core-utils are installed
	if [[ ! -d $(brew --prefix)/Cellar/coreutils ]]; then
		echo "CoreUtils was not found… making an install"
		base=(
			coreutils
			findutils
			gnu-tar
			gnu-sed
			gnu-indent
			moreutils
		)
		brew install ${base[@]} --with-default-names
		brew install grep --with-default-names
	fi

	echo "Installing dependencies…"
	deps=(
		git
		bash
		bash-completion
		python
		tree
		ack
		nvm
	)
	brew install ${deps[@]}

	if [[ ! -d  ~/.nvm ]]; then
		echo "Installing stable node binary…"
		mkdir ~/.nvm
		nvm install stable
		nvm alias default stable
	fi

	echo "Making Bash4 the default shell…"
	brew link --overwrite bash

	echo "Cleaning up the house…"
	brew cleanup  > /dev/null 2>&1
	brew prune  > /dev/null 2>&1

# is this ArchLinux? PacMan baby!
elif [ -f "/etc/arch-release" ]; then

	echo "Updating system and installing dependencies…"
	deps=(
		moreutils
		dnsutils
		python
		ruby
		git
	)
	sudo pacman -Syu --noconfirm ${deps[@]}
	echo "Installing NVM"
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.1/install.sh | bash
fi
