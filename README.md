About
=====

These are my dotfiles.

Quickstart:

    git clone --recursive $URL
    cd dotfiles
    ./setup.sh


Misc tips
=========

* If you forgot the --recursive (or if you just did a git pull and got new
  submodules, but need to update them)

        git submodule update --init
        # OR
        make update

* To upgrade the submodules

        make upgrade-submodules

* Git credential helper (gnome-keyring)

        sudo apt-get install libgnome-keyring-dev
        cd /usr/share/doc/git/contrib/credential/gnome-keyring
        sudo make


Setting up muttrc password
==========================

```
echo 'set imap_pass="XXX"' > ~/.muttrc.password
gpg -r andrei@vacariu.ca -e ~/.muttrc.password   # output ~/.muttrc.password.gpg
rm ~/.muttrc.password
```
