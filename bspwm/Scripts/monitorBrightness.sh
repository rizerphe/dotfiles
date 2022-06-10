# !/bin/sh

for m in $(xrandr --current | grep ' connected' | awk ' {print $1} '); do
    xrandr --output $m --brightness 0.6
done