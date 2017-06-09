#!/bin/bash

xset +dpms

revert() {
    xset dpms 0 0 0
}

trap revert HUP INT TERM

if [[ $1 != "immediate" ]]; then
    # Wait 5 seconds before locking the screen to give the user a few seconds
    # to move the mouse
    xset dpms force off
    sleep 5

    if xset q | grep --quiet '^  Monitor is On'; then
	revert
	exit
    fi
fi

xset dpms 30 30 30
i3lock -i $HOME/Pictures/wallpapers/Black_Diamonds.png -t -n
revert
