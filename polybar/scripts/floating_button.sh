#!/bin/bash

if [ ! -f "$HOME/.config/polybar/.floating-lock.txt" ]; then
    echo 0 > "$HOME/.config/polybar/.floating-lock.txt"
fi

function togglePausedVisibility() {
    if [ `cat ~/.config/polybar/.floating-lock.txt` == "1" ] ; then
        echo 0 > ~/.config/polybar/.floating-lock.txt
    else
        echo 1 > ~/.config/polybar/.floating-lock.txt
    fi
}

if [ "$1" == "--toggle" ]; then
    togglePausedVisibility
else
    if [ `cat ~/.config/polybar/.floating-lock.txt` == "1" ] ; then
        echo ""
    else
        echo ""
    fi
fi
