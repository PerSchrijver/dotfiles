#!/bin/bash
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
pidof spotify
if [ $? -ne 0 ]
then
  nohup spotify &
fi
