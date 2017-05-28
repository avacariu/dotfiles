#!/bin/bash

# NOTE: That `xset` won't turn off the screen if this script is run by
# xautolock! You'll need to use xset with a delay in the i3 config

i3lock -i $HOME/Pictures/wallpapers/Black_Diamonds.png -t
sleep 30
pgrep i3lock && xset dpms force off
