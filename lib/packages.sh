if $(has python); then

	# Enable VirtualEnvWrapper
	if ! $(has virtualenv); then
		echo "Virtualenv was not found, installing it ..."
		pip install --upgrade setuptools
		pip install --upgrade pip
		pip install virtualenv
		pip install virtualenvwrapper
	fi
	export WORKON_HOME=$HOME/.virtualenvs
	source $(brew --prefix)/bin/virtualenvwrapper.sh

fi

# Ruby environment management.
if $(has ruby); then
	rbenv_installed=false
	if ! $(has rbenv); then
		echo "Rbenv was not found, installing it ..."
		brew install rbenv ruby-build
		rbenv_installed=true
	fi
	if ! $(isLinux); then
		export GEM_HOME=$(brew --prefix)/opt/gems
		export GEM_PATH=$(brew --prefix)/opt/gems
		export RBENV_ROOT=$(brew --prefix rbenv)
		export PATH=$GEM_PATH/bin:$PATH
	fi
	eval "$(rbenv init -)"
	if [[ ${rbenv_installed} == true || $(rbenv global) == 'system' ]]; then
		echo "Installing latest version of ruby."
		rbenv_ver=$(rbenv install --list | grep -P '^\s*\d+\.\d+\.\d+$' | tail -n1 | xargs)
		rbenv install $rbenv_ver
		rbenv global $rbenv_ver
	fi
	rbenv shell $(rbenv global)
	rbenv rehash
fi

# Google Cloud SDK.
gc_prefix="$HOME/Source/External"
gc_dirname='google-cloud-sdk'
if [ ! -d "$gc_prefix/$gc_dirname" ]; then
	[ ! -d "$gc_prefix" ] && mkdir -p $gc_prefix
	curl https://sdk.cloud.google.com | PREFIX=$gc_prefix bash
fi
source "$gc_prefix/$gc_dirname/path.bash.inc"
source "$gc_prefix/$gc_dirname/completion.bash.inc"
