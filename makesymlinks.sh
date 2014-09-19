#!/bin/bash

dir=~/dotfiles
olddir=~/dotfiles.bak
files="bashrc vimrc vim gitconfig byobu irssi"

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
	ln -s $dir/$file ~/.$file
done

echo "Setting up .local/bin"
mkdir -p ~/.local/bin

echo "Copying bashmarks to .local/bin"
cp $dir/local/bin/bashmarks/bashmarks.sh ~/.local/bin/
