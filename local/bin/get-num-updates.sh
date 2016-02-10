#!/bin/bash

FILE=/tmp/NUM_APT_UPDATES_SOME_RANDOM_TEXT
LOCK=$FILE-lock

if [ ! -x /usr/lib/update-notifier/apt-check ]; then
    exit
fi

# first we just want to just return the value we computed before
if [ -e $FILE ]; then
    cat $FILE
fi

# afterwards, we want to update the value in the file
if ! [ -e $LOCK ]; then
    # grab the lock in the main thread to minimize race conditions
    touch $LOCK
    {
        /usr/lib/update-notifier/apt-check 2>&1 | sed 's/;.*//' | sed 's/0//' > ${FILE}-2
        mv ${FILE}-2 ${FILE}

        # make sure we keep the lock for another 30 seconds so that we don't check
        # the number of updates more often than every 30 seconds
        sleep 30
        rm -f $LOCK
    } &
fi
