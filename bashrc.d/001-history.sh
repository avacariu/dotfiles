# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# disable history limits, but only for non-macs because macs seem to fail to
# save any history when these values are unset.
# TODO: Consider using Eli Bendersky's code for persistent history: https://github.com/eliben/code-for-blog/blob/master/2016/persistent-history/add-persistent-history.sh
if [[ ! $OSTYPE =~ darwin* ]]; then
    export HISTSIZE=-1
    unset HISTFILESIZE
fi

HISTTIMEFORMAT="%F %T "
