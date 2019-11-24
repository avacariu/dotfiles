#!/usr/bin/env bash

dir=$(pwd)
files="bashrc vimrc vim bashrc.d gitconfig gitignore irssi tmux.conf latexmkrc"

echo "Installing pipx"
python3 -m pip install --user pipx
python3 -m pipx ensurepath

echo "Moving any existing dotfiles from - to $olddir"
for file in $files; do
    if [[ -a ~/.$file ]]; then
        mv ~/.$file ~/.$file.bak
    fi
	echo "Creating symlink to $file in home directory."
	ln -s -f $dir/$file ~/.$file
done

echo "Setting up .local/bin"
mkdir -p ~/.local/bin
ln -s -f $dir/local/bin ~/.local/bin/dotfiles

echo "Copying i3 configs"
mkdir -p ~/.config/{i3,i3status}
ln -s -f $dir/i3/config ~/.config/i3/config
ln -s -f $dir/i3status/config ~/.config/i3status/config

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
