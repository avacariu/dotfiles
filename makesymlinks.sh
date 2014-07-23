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

for file in $files; do
	echo "Moving any existing dotfiles from - to $olddir"
    if [ -a ~/.$file ]; then
        mv ~/.$file $olddir/
    fi
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/.$file
done
