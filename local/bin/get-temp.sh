#!/bin/bash

TEMP_FILE=/sys/class/thermal/thermal_zone0/temp

if [ -e $TEMP_FILE ]; then
    echo $(cat $TEMP_FILE | cut -c 1-2)°
fi
