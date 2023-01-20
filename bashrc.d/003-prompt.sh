# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

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

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

if [ "$color_prompt" = yes ]; then
    PS1='\n\[\e[1m\e[31m\]+\[\e[0m\] '
    PS1="$PS1"'$(virtualenv_info)'
    PS1="$PS1"'${debian_chroot:+($debian_chroot)}'
    PS1="$PS1"'\[\e[01m\e[38;5;10m\]\u@\h\[\e[0m\]'
    PS1="$PS1"':\[\e[01m\e[38;5;12m\]\w\[\e[0m\]'
    PS1="$PS1"'\[\e[01m\e[38;5;10m\]$(declare -F __git_ps1 &>/dev/null && __git_ps1 " (%s)")\[\e[0m\]\n'
    #PS1="$PS1"'\n\[\e[1;35m\]\$ \[\e[0m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w \$ '
fi
unset color_prompt force_color_prompt

bind 'set vi-ins-mode-string "\1\e[1;35m\2$\1\e[0m\2 "'
bind 'set vi-cmd-mode-string "\1\e[1;35m\2:\1\e[0m\2 "'

# Shorten the promt so it only shows ~/.../dir2/dir2$
export PROMPT_DIRTRIM=2
