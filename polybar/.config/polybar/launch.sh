#!/bin/sh
# (Re)start the Gruvbox top bar. Cinnamon runs this at login (Startup Applications); run it again after editing config.ini.
# The bar has no tray: Wi-Fi and volume are polybar modules. nm-applet still runs in the background (started by
# the system at login) because it answers Wi-Fi password prompts, but it has no icon to show.
pkill -x polybar
# In bspwm, keep the bar just above bspwm's own base layer so fullscreen windows (games, video) cover it.
# Cinnamon doesn't need this, so it's only switched on when bspwm is running (see wm-restack in config.ini).
pgrep -x bspwm >/dev/null && export POLYBAR_WM_RESTACK=bspwm
while pgrep -x polybar >/dev/null; do sleep 0.2; done
polybar main >"$HOME/.cache/polybar.log" 2>&1 &
