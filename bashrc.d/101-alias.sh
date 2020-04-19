# vim: let b:is_bash = 1
# some more ls aliases
alias ll='ls -lah'
alias la='ls -a'
alias l='ls -c'
alias sl='ls'

# this ensures bc always starts with scale=20
alias bc='bc -l'

alias cd..="cd .."
alias ..="cd .."
alias psg="ps aux | grep"
alias ris="tput reset"
alias cdh='cd $(pwd)'
alias cd-="cd -"
alias nt="nautilus --no-desktop ."
alias :e="vim"
alias vim.="vim ."
alias ed="ed -p:"
alias ta="tmux attach || tmux new-session"
alias py3="python3"
alias naut="nautilus --no-desktop"
alias ga="git add"
alias gau="git add -u"
# make tmux use 256 color. Unfortunately setting this in .tmux.conf isn't
# enough
alias tmux="tmux -2"
alias .v="source venv/bin/activate"

alias sshfs-reconnect="sshfs -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
