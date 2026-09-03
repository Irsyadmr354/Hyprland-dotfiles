#!/usr/bin/env bash

# Minimalist Nord Power Menu using Rofi

OPTIONS="󰌾  Lock\n󰤄  Suspend\n󰍃  Logout\n󰑐  Reboot\n󰐥  Shutdown"

CHOSEN=$(echo -e "$OPTIONS" | rofi -dmenu -click-to-exit -kb-cancel Escape \
    -p "Power" \
    -theme-str '
    window {
        location: center;
        anchor: center;
        width: 260px;
        height: 250px;
        border: 1px;
        border-color: #333333;
        background-color: #141414;
        border-radius: 14px;
    }
    mainbox {
        background-color: #141414;
        padding: 12px;
        children: [ inputbar, listview ];
        spacing: 10px;
    }
    inputbar {
        background-color: #1E1E1E;
        border: 1px;
        border-color: #333333;
        border-radius: 10px;
        padding: 4px;
        children: [ prompt ];
    }
    prompt {
        text-color: #EDEDED;
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
        text-color: #EDEDED;
        border-radius: 8px;
    }
    element selected {
        background-color: #EDEDED;
        text-color: #141414;
        font-weight: bold;
        border-radius: 8px;
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
