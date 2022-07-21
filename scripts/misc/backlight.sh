#!/bin/bash

subinc=2
subchange=$(echo "1 / $subinc" | bc -l)
delay=$(echo "(0.02 / $2)/$subinc" | bc -l)
opt=""

if [ "$1" == "inc" ]; then
    opt="-A"
else
    opt="-U"
fi

for i in $(seq $2); do
    current=$(light)
    truncated=$(echo "$current" | cut -d '.' -f1)

    if (( $(echo "$current==0" | bc -l) )) && [ "$opt" == "-U" ]; then
        exit 0;
    elif (( $(echo "$current==100" | bc -l) )) && [ "$opt" == "-A"  ]; then
        exit 0;
    fi

    for i in $(seq $subinc); do
        light $opt "$subchange"
        sleep "$delay"
    done
done
