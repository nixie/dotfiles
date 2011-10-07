#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

[ -f /etc/profile ] && . /etc/profile

setxkbmap cz_qwerty; xmodmap .Xmodmap

. /home/collodi/.config/awesome/autostart.sh &

/usr/bin/awesome 2>&1 > ~/.logs/awesome
