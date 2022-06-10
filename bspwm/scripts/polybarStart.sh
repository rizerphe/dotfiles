#!/bin/sh

# Kill all programs
#  hideit
ps -ef | grep hideIt | grep -v grep | awk '{print $2}' | xargs kill
#  polybar
killall -q polybar

# Start the bar
polybar floating -r -l warning &

# Give it a second to start up
sleep 1

# Start hiding it
echo 0 > ~/.config/polybar/.lock.txt
~/.config/polybar/scripts/hideIt.sh -N "polybar-floating_*" -r 0x0+1920+-10 -d top -p 0 -i .5 -w -l ~/.config/polybar/.floating_lock.txt &

# Raise it above everything
bspc config top_padding 0
sleep 5
bspc config top_padding 0

wait
