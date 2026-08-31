#!/usr/bin/env bash

# Minimalist brightness notification with progress bar using notify-send (SwayNC)

case "$1" in
    raise)
        brightnessctl s 5%+
        ;;
    lower)
        brightnessctl s 5%-
        ;;
esac

BRIGHTNESS=$(brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}')

notify-send -h string:x-canonical-private-synchronous:osd \
            -h int:value:"$BRIGHTNESS" \
            -u low "Brightness" "${BRIGHTNESS}%"
