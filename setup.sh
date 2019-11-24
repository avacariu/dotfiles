#!/usr/bin/env bash

dir=$(pwd)

SYMLINK="ln -s -f -n"

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
	$SYMLINK $dir/$file ~/.$file
    done

    echo "Copying i3 configs"
    mkdir -p ~/.config/{i3,i3status}
    $SYMLINK $dir/i3/config ~/.config/i3/config
    $SYMLINK $dir/i3status/config ~/.config/i3status/config
}

function install_bin() {
    echo "Setting up .local/bin"
    mkdir -p ~/.local/bin
    $SYMLINK $dir/local/bin ~/.local/bin/dotfiles
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
    install_pipx
    install_config_files
    install_bin
    install_fonts
}

install
