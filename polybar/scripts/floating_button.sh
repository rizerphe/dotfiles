#!/bin/bash


function togglePausedVisibility() {
    if [ `cat ~/.config/polybar/.lock.txt` == "1" ] ; then
        echo 0 > ~/.config/polybar/.lock.txt
    else
        echo 1 > ~/.config/polybar/.lock.txt
    fi
}

if [ "$1" == "--toggle" ]; then
    togglePausedVisibility
else
    if [ `cat ~/.config/polybar/.lock.txt` == "1" ] ; then
        echo ""
    else
        echo ""
    fi
fi
