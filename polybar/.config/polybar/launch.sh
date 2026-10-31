#!/bin/sh
# (Re)start the Gruvbox top bar. Cinnamon runs this at login (Startup Applications); run it again after editing config.ini.
pkill -x polybar
while pgrep -x polybar >/dev/null; do sleep 0.2; done
polybar main >"$HOME/.cache/polybar.log" 2>&1 &

# Tray apps that live in the bar's tray: Wi-Fi menu (nm-applet) and volume slider (~/.local/bin/volume-tray).
# They're restarted after the bar so they dock into its new tray.
sleep 1
for app in nm-applet "$HOME/.local/bin/volume-tray"; do
    command -v "$app" >/dev/null || continue
    pkill -x "$(basename "$app")"
    setsid "$app" >/dev/null 2>&1 &
done
