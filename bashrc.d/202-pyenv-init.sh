if [[ -d ~/.pyenv ]]; then
    export PYENV_HOME="$HOME/.pyenv"
    export PATH="$PYENV_HOME/bin:$PATH"

    eval "$(pyenv init -)"
fi
