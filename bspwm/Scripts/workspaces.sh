# !/bin/sh

i=1
for monitor in $(bspc query -M); do
	bspc monitor $monitor -n "$i" -d $i/{I,II,III,IV}
	let i++
done
