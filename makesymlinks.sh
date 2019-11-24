#!/usr/bin/env bash

dir=$(pwd)
olddir=$(pwd)/../dotfiles.bak
files="bashrc vimrc vim bashrc.d gitconfig gitignore irssi tmux.conf latexmkrc"

echo "Creating $olddir to backup any existing dotfiles in -"
mkdir -p $olddir
echo "...done"

echo "Changing to the $dir directory"
cd $dir
echo "...done"

echo "Moving any existing dotfiles from - to $olddir"
for file in $files; do
    if [ -a ~/.$file ]; then
        mv ~/.$file $olddir/
    fi
	echo "Creating symlink to $file in home directory."
	ln -s -f $dir/$file ~/.$file
done

echo "Setting up .local/bin"
mkdir -p ~/.local/bin

echo "Copying i3 configs"
mkdir -p ~/.config/{i3,i3status}
cp $dir/i3/config ~/.config/i3/config
cp $dir/i3status/config ~/.config/i3status/config

echo "Copying get-num-updates to .local/bin"
cp $dir/local/bin/get-num-updates.sh ~/.local/bin/

echo "Copying get-temp to .local/bin"
cp $dir/local/bin/get-temp.sh ~/.local/bin/

echo "Setting up powerline fonts"
cd /tmp

if which -s wget; then
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
else
    # This is mostly going to be Macs
    curl https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf --output PowerlineSymbols.otf
    curl https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf --output 10-powerline-symbols.otf
fi

mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
