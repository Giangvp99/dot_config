#! /usr/bin/bash

nitrogen --restore&
xmodmap ~/.Xmodmap&
xcape -e 'Control_L=Escape'&
dunst&
picom --config $HOME/.config/picom/picom.conf&
kitty&
nm-applet&
blueman-applet&
