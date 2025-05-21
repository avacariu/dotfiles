if [[ $OSTYPE = darwin* ]]; then
    export PATH="/usr/local/sbin:$PATH"
fi

export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin/dotfiles:$PATH"
export PATH="$HOME/.local/bin/anaconda2/bin:$PATH"
export PATH="$HOME/.local/anaconda3/bin:$PATH"
export PATH="$HOME/.local/bin/ale:$PATH"

export TEXINPUTS="$HOME/dotfiles/texmf:$TEXINPUTS"
