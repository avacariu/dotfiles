#!/bin/bash

OLD_TIMEOUT=$(xset q | grep --perl-regexp -o 'Standby: \K\d+')

revert() {
    xset dpms $OLD_TIMEOUT $OLD_TIMEOUT $OLD_TIMEOUT
}

trap revert HUP INT TERM

xset +dpms
xset dpms force off

sleep 5

if xset q | grep --quiet '^  Monitor is On'; then
    exit
fi

xset dpms 30 30 30
i3lock -i $HOME/Pictures/wallpapers/Black_Diamonds.png -t -n
revert
