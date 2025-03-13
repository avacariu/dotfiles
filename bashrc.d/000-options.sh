# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

shopt -s globstar

set -o vi
bind 'set show-mode-in-prompt on'
