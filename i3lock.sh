#!/bin/bash

OLD_TIMEOUT=$(xset q | grep --perl-regexp -o 'Standby: \K\d+')

xset dpms 30 30 30
i3lock -i $HOME/Pictures/wallpapers/Black_Diamonds.png -t -n
xset dpms $OLD_TIMEOUT $OLD_TIMEOUT $OLD_TIMEOUT
