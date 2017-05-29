#!/bin/bash

OLD_TIMEOUT=$(xset q | grep --perl-regexp -o 'Standby: \K\d+')

revert() {
    xset dpms $OLD_TIMEOUT $OLD_TIMEOUT $OLD_TIMEOUT
}

trap revert HUP INT TERM

xset +dpms

# NOTE: Setting timeouts has to be before the 'force off' because otherwise the
# screen will turn back on. It still turns back on sometimes, but this makes it
# less likely to do so.
xset dpms 30 30 30
xset dpms force off

if [[ $1 != "immediate" ]]; then
    # Wait 5 seconds before locking the screen in case the mouse got moved
    sleep 5

    if xset q | grep --quiet '^  Monitor is On'; then
	revert
	exit
    fi
fi

i3lock -i $HOME/Pictures/wallpapers/Black_Diamonds.png -t -n
revert
