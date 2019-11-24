#!/usr/bin/env bash

dir=$(pwd)
# It's way too difficult to handle edge cases where you end up putting things
# within symlinks, so it's easier to just create a new directory for each
# backup date.
backupdir=$(pwd)/../dotfiles.bak/$(date "+%Y-%m-%d_%H-%M.%S")
mkdir -p $backupdir

function symlink() {
    local src="$1"
    local tgt="$2"

    if [[ -f $tgt ]] || [[ -d $tgt ]]; then
	mv $tgt $backupdir/$(basename "$tgt")
    fi

    ln -s -f -n "$src" "$tgt"
}

function install_pipx() {
    echo "Installing pipx"
    python3 -m pip install --user pipx
    python3 -m pipx ensurepath
}

function install_config_files() {
    files="bashrc vimrc vim bashrc.d gitconfig gitignore irssi tmux.conf latexmkrc"

    echo "Moving any existing dotfiles from - to $olddir"
    for file in $files; do
	echo "Creating symlink to $file in home directory."
	symlink $dir/$file ~/.$file
    done

    echo "Copying i3 configs"
    mkdir -p ~/.config/{i3,i3status}
    symlink $dir/i3/config ~/.config/i3/config
    symlink $dir/i3status/config ~/.config/i3status/config
}

function install_bin() {
    echo "Setting up .local/bin"
    mkdir -p ~/.local/bin
    symlink $dir/local/bin ~/.local/bin/dotfiles
}

function install_fonts() {
    if [[ $OSTYPE =~ darwin* ]]; then
	echo "iTerm2 supports powerline fonts natively"
	echo "iTerm2 > Preferences > Profiles > Text > Use built-in Powerline glyphs"
    else
	echo "Setting up powerline fonts"
	cd $(mktemp -d)

	git clone https://github.com/powerline/fonts.git --depth=1
	cd fonts
	./install.sh
	cd -
    fi
}

function install() {
    echo "This script may have imperfect backups. Do you wish to continue?"
    select yn in "Yes" "No"; do
	case $yn in
	    Yes)
		echo "Backup directory: $backupdir"
		install_pipx
		install_config_files
		install_bin
		install_fonts
		;;
	    *)
		echo "Exiting..."
		;;
	esac
	break
    done
}

install
