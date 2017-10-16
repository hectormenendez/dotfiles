# Hector Menendez's DotFiles
> The utilities I'm currently using for my terminal needs.

## Installer

Run this on your terminal.

```bash
git clone https://github.com/hectormenendez/dotfiles /path/of/your/liking
cd /path/of/your/liking
./install
```

Grab a cup of coffee, browse reddit, swipe on tinder… it's gonna take a while.

Once installed the installer will be availabel globally as `dotfiles-install` you can pass
you can pass arguments to it to setup/reinstall parts of the dotfiles.

**Arguments**

-  `--skip` skip installations steps or packages. Note you can pass a comma-separated list
            list of vales. `--skip=links,brew,emacs` just remember not to use spaces.

    - `links` Skips dotfiles linking.
    - `brew` Skips Homebrew (re)installation (MacOS only)
    - `packages` Skips installation of packages. Additionally, you can pass a specific
                 package name.

-  `--force` forces the reinstallation of a package. you can also pass a comma-separated
             list of values like `--force=emacs,python3` if you want to reinstall every
             package pass `--force=packages`


## Binaries

Well, not really binaries, but you get the point. I included some scripts I use regularly
when working with the tools included here. There are adapted to work for my needs,
so don't judge. 😒

- `git-migrate` A tool to migrate git repositories (or parts of them) for documentation
                just type `git-migrate` on your terminal.

- `history-dedupe` A small tool to  remove duplicates from HISTFILE.
                 (Called from bash_profile)
