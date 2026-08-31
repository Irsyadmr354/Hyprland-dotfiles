#!/usr/bin/env bash

# Minimalist volume notification with progress bar using notify-send (SwayNC)

case "$1" in
    raise)
        pamixer -u -i 5
        ;;
    lower)
        pamixer -u -d 5
        ;;
    mute)
        pamixer -t
        ;;
esac

VOLUME=$(pamixer --get-volume)
MUTED=$(pamixer --get-mute)

if [ "$MUTED" = "true" ]; then
    notify-send -h string:x-canonical-private-synchronous:osd \
                -h int:value:0 \
                -u low "Volume" "Muted (0%)"
else
    notify-send -h string:x-canonical-private-synchronous:osd \
                -h int:value:"$VOLUME" \
                -u low "Volume" "${VOLUME}%"
fi
