#! /bin/bash
xset r rate 150 150
feh --bg-scale ~/.config/background.jpg
# sudo ~/scripts/powertop-fix
# [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
localctl set-keymap us
setxkbmap -layout us,ru
setxkbmap -option 'grp:alt_shift_toggle'
redshift &
