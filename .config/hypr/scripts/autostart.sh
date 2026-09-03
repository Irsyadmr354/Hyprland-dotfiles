#!/usr/bin/env bash

# Hyprland Autostart Background Daemon Manager

# 1. D-Bus & XDG Environment
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# 2. Polkit & Keyring (VS Code credentials & secrets)
pgrep -x hyprpolkitagent >/dev/null || /usr/lib/hyprpolkitagent/hyprpolkitagent &
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh 2>/dev/null)
export SSH_AUTH_SOCK

# 3. Kill existing instances to prevent duplicates
killall waybar swaync swaybg hyprpaper hypridle 2>/dev/null

# 4. Launch Desktop UI components
~/.config/hypr/scripts/change_wallpaper.sh init &
waybar &
swaync &
hypridle &

# 5. Clipboard Manager (Cliphist)
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
