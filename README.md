About
=====

These are my dotfiles.


Setting it up
=============

* Pulling the repo

        git clone --recursive

* If you forgot the --recursive (or if you just did a git pull and got new
  submodules, but need to update them)

        git submodule update --init

* To update the submodules

        git submodule foreach git pull origin master

* Git credential helper (gnome-keyring)

        sudo apt-get install libgnome-keyring-dev
        cd /usr/share/doc/git/contrib/credential/gnome-keyring
        sudo make

Updating YouCompleteMe
======================

    git submodule update --init --recursive
    ./install.sh --clang-completer --system-libclang
