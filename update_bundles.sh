git submodule foreach git pull origin master
cd ./vim/bundle/YouCompleteMe
git submodule update --recursive

./install.sh --clang-completer --system-libclang
