#!/bin/bash

OLD_TIMEOUT=$(xset q | grep --perl-regexp -o 'Standby: \K\d+')

revert() {
    xset dpms $OLD_TIMEOUT $OLD_TIMEOUT $OLD_TIMEOUT
}

trap revert HUP INT TERM

xset +dpms dpms 30 30 30
i3lock -i $HOME/Pictures/wallpapers/Black_Diamonds.png -t -n
revert
