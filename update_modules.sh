#!/bin/bash

git submodule foreach git pull origin master
git submodule foreach git submodule update --init --recursive

cd vim/bundle/YouCompleteMe
./install.py --clang-completer
