#!/bin/bash


function toggleCaps() {
    if [ `cat ~/.config/polybar/.nvimb-lock.txt` == "1" ] ; then
        echo 0 > ~/.config/polybar/.nvimb-lock.txt
        setxkbmap -option
    else
        echo 1 > ~/.config/polybar/.nvimb-lock.txt
        setxkbmap -option caps:escape
    fi
}

if [ "$1" == "--toggle" ]; then
    toggleCaps
else
    if [ `cat ~/.config/polybar/.nvimb-lock.txt` == "1" ] ; then
        echo ""
    else
        echo ""
    fi
fi
