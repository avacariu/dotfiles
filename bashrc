# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

for f in ~/.bashrc.d/*; do
    source "$f";
done


complete -F _new-complete new

bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

export DEBFULLNAME="Andrei Vacariu"
export DEBEMAIL="andrei@avacariu.me"

source ~/.local/bin/bashmarks.sh
source "$MODULESHOME"/init/bash 2>/dev/null
source "$MODULESHOME"/init/bash_completion 2>/dev/null

source ~/.bashrc_local 2>/dev/null

if [[ -d ~/.pyenv ]]; then
    export PYENV_HOME="$HOME/.pyenv"
    export PATH="$PYENV_HOME/bin:$PATH"

    eval "$(pyenv init -)"
fi

if [[ -f ~/.local/bin/register-python-argcomplete ]]; then
    eval "$(register-python-argcomplete pipx)"
fi


# credit: https://unix.stackexchange.com/a/217223
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    if [[ -z $SSH_AUTH_SOCK ]]; then
        eval "$(ssh-agent)"
    fi
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
