# credit: https://unix.stackexchange.com/a/217223
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    if [[ -z $SSH_AUTH_SOCK ]]; then
        eval "$(ssh-agent)"
    fi
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
