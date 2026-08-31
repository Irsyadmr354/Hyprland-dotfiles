#!/usr/bin/env bash

# Hyprland Autostart Background Daemon Manager

# 1. D-Bus & XDG Environment
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# 2. Polkit Authentication Agent
/usr/lib/polkit-kde-authentication-agent-1 &

# 3. Kill existing instances to prevent duplicates
killall waybar swaync hyprpaper hypridle 2>/dev/null

# 4. Launch Desktop UI components
waybar &
swaync &
hyprpaper &
hypridle &

# 5. Clipboard Manager (Cliphist)
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
