# If not running without a display, don't do anything
[ -z "$DISPLAY" ] && return


# set US keyboard and ctrl instead of caps lock
setxkbmap -layout us -option ctrl:nocaps

# increase keyboard repeat
xset r rate 220 34

# turn screen black/off in ~10min?
xset dpms 600 630
