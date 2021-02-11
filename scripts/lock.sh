#!/bin/sh -e

# don't leak old i3lock processes
#killall i3lock 2> /dev/null || true

# Take a screenshot
scrot --overwrite /tmp/screen_locked.png

# Pixellate it 10x
mogrify -scale 10% -scale 1000% /tmp/screen_locked.png

# Lock screen displaying this image.
i3lock -i /tmp/screen_locked.png
