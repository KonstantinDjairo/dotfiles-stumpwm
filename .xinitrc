#!/bin/sh

numlockx on
xsetroot -cursor_name left_ptr
xset r rate 200 70
xrdb -load $HOME/.Xresources

exec dbus-launch --exit-with-session stumpwm
