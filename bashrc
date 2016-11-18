# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# disable history limits
# TODO: Consider using Eli Bendersky's code for persistent history: https://github.com/eliben/code-for-blog/blob/master/2016/persistent-history/add-persistent-history.sh
export HISTSIZE=-1
unset HISTFILESIZE

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

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w \$ '
fi
unset color_prompt force_color_prompt

# Shorten the promt so it only shows ~/.../dir2/dir2$
export PROMPT_DIRTRIM=2

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

alias cd..="cd .."
alias ..="cd .."
alias psg="ps aux | grep"
alias ris="tput reset"
alias cdh='cd $(pwd)'
alias cd-="cd -"
alias nt="nautilus --no-desktop ."
alias :e="gvim"
alias ed="ed -p:"
alias ta="tmux attach || tmux new-session"
alias py3="python3"
alias naut="nautilus --no-desktop"
alias ga="git add"
alias gau="git add -u"
# make tmux use 256 color. Unfortunately setting this in .tmux.conf isn't
# enough
alias tmux="tmux -2"

alias sshfs-reconnect="sshfs -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3"

bd() {
    if [[ -z $1 ]]; then
        cd /
        return
    else
        local newdir=$(dirname "$(pwd)")
    fi

    while [[ $(basename "$newdir") != *$1* ]] && [[ $(basename "$newdir") != "/" ]]; do
        newdir=$(dirname "$newdir")
    done

    if [[ $newdir == "/" ]]; then
        echo "No directory containing '$1' found."
    else
        echo $newdir
        cd $newdir
    fi
}

mkd() {
    mkdir $1 && cd $1
}

numfiles() {
    for dir in "$@"; do
        /bin/echo -e "$(find "$dir" -type f | wc -l) \t $dir"
    done
}

new() {
    cp $HOME/Templates/$1 $2
}

_new-complete() {
    IFS=$'\n' tmp=( $(compgen -W "$(ls "$HOME/Templates/")" -- "${COMP_WORDS[$COMP_CWORD]}" ))
    COMPREPLY=( "${tmp[@]// /\ }" )
}

encrypt() {
  openssl enc -aes256 -pass pass:"$1" -in "$2" -out "$2".encrypted
}

decrypt() {
  openssl enc -d -aes256 -pass pass:"$1" -in "$2" -out "$2".decrypted
}

print-tmux-colors() {
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}mcolour${i}\n"
    done
}

complete -F _new-complete new

bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

export DEBFULLNAME="Andrei Vacariu"
export DEBEMAIL="andrei@avacariu.me"

source ~/.local/bin/bashmarks.sh
source $MODULESHOME/init/bash 2>/dev/null
source $MODULESHOME/init/bash_completion 2>/dev/null

source $HOME/.path-prepends.sh
