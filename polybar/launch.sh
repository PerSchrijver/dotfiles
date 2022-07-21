#!/bin/bash

pkill polybar
primary=$(xrandr --query | grep primary | cut -d" " -f1)
for m in $(polybar --list-monitors | cut -d":" -f1); do\
    if [[ $primary == $m ]]; then
        MONITOR=$m polybar --reload main &
    else
        MONITOR=$m polybar --reload second-monitor &
    fi
done
