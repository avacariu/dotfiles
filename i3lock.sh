#!/bin/bash

OLD_TIMEOUT=$(xset q | grep --perl-regexp -o 'Standby: \K\d+')

# XXX This is a workaround for xset in i3/config not setting DPMS timeouts
# properly
if [[ $OLD_TIMEOUT -eq 0 ]]; then
    OLD_TIMEOUT=300
fi

xset dpms 30 30 30
i3lock -i $HOME/Pictures/wallpapers/Black_Diamonds.png -t -n
xset dpms $OLD_TIMEOUT $OLD_TIMEOUT $OLD_TIMEOUT
