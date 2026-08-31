#!/usr/bin/env bash

# Minimalist Nord Power Menu using Rofi

OPTIONS="󰌾  Lock\n󰤄  Suspend\n󰍃  Logout\n󰑐  Reboot\n󰐥  Shutdown"

CHOSEN=$(echo -e "$OPTIONS" | rofi -dmenu \
    -p "Power" \
    -theme-str '
    window {
        location: center;
        anchor: center;
        width: 260px;
        height: 250px;
        border: 2px;
        border-color: #88c0d0;
        background-color: #2e3440;
    }
    mainbox {
        background-color: #2e3440;
        padding: 12px;
        children: [ inputbar, listview ];
        spacing: 10px;
    }
    inputbar {
        background-color: #3b4252;
        border: 1px;
        border-color: #434c5e;
        padding: 4px;
        children: [ prompt ];
    }
    prompt {
        text-color: #88c0d0;
        font-weight: bold;
        padding: 2px 6px;
    }
    listview {
        background-color: transparent;
        lines: 5;
        columns: 1;
        spacing: 4px;
    }
    element {
        padding: 6px 10px;
        background-color: transparent;
        text-color: #eceff4;
    }
    element selected {
        background-color: #88c0d0;
        text-color: #2e3440;
        font-weight: bold;
    }
    ')

case "$CHOSEN" in
    *"Lock"*)
        hyprlock
        ;;
    *"Suspend"*)
        systemctl suspend
        ;;
    *"Logout"*)
        hyprctl dispatch "hl.dsp.exit()" || killall Hyprland
        ;;
    *"Reboot"*)
        systemctl reboot
        ;;
    *"Shutdown"*)
        systemctl poweroff
        ;;
esac
