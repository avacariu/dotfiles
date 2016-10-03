#!/bin/bash

# this makes it so we exit if flock fails
set -e

FILE=/tmp/NUM_APT_UPDATES

if [ ! -x /usr/lib/update-notifier/apt-check ]; then
    exit
fi

# first we just want to just return the value we computed before
if [ -e $FILE ]; then
    cat $FILE
fi

# NOTE: we're running this in the background so that the first execution of
# this script returns quickly and TMUX doesn't display <SCRIPT not ready>
(
    # if we don't get the lock, it doesn't matter so we'll pretend we were
    # successfull
    flock --nonblock 200 || exit 0

    /usr/lib/update-notifier/apt-check 2>&1 | sed 's/;.*//' | sed 's/^0$//' > ${FILE}

    # make sure we keep the lock for another 30 seconds so that we don't check
    # the number of updates more often than every 30 seconds
    sleep 30

) 200>/var/lock/num-apt-updates.lock &
