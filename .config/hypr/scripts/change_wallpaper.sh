#!/usr/bin/env bash

# Minimalist wallpaper switcher and loader using swaybg

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CURRENT_WP_FILE="$HOME/.config/hypr/current_wallpaper"

mkdir -p "$WALLPAPER_DIR"

ACTION="${1:-next}"

# Find all valid image files
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) 2>/dev/null | sort)

TOTAL=${#WALLPAPERS[@]}

if [ $TOTAL -eq 0 ]; then
    notify-send -u low "Wallpaper" "No wallpapers found in ~/Pictures/Wallpapers/"
    exit 1
fi

CURRENT_WP=""
if [ -f "$CURRENT_WP_FILE" ]; then
    CURRENT_WP="$(cat "$CURRENT_WP_FILE")"
fi

if [ "$ACTION" == "init" ]; then
    # Load previously saved wallpaper or fallback to first
    if [ -n "$CURRENT_WP" ] && [ -f "$CURRENT_WP" ]; then
        TARGET_WP="$CURRENT_WP"
    else
        TARGET_WP="${WALLPAPERS[0]}"
    fi
else
    # Sequential / Guaranteed Different Wallpaper Selection
    if [ $TOTAL -eq 1 ]; then
        TARGET_WP="${WALLPAPERS[0]}"
    else
        # Find index of current wallpaper
        CURRENT_INDEX=-1
        for i in "${!WALLPAPERS[@]}"; do
            if [ "${WALLPAPERS[$i]}" == "$CURRENT_WP" ]; then
                CURRENT_INDEX=$i
                break
            fi
        done

        # Cycle to next wallpaper guaranteed
        NEXT_INDEX=$(( (CURRENT_INDEX + 1) % TOTAL ))
        TARGET_WP="${WALLPAPERS[$NEXT_INDEX]}"
    fi
fi

if [ -n "$TARGET_WP" ] && [ -f "$TARGET_WP" ]; then
    echo "$TARGET_WP" > "$CURRENT_WP_FILE"
    
    # Spawn new swaybg instance before killing old for seamless transition
    swaybg -i "$TARGET_WP" -m fill &
    NEW_PID=$!
    sleep 0.15
    
    # Kill any older swaybg instances
    pgrep -x swaybg | grep -v "^${NEW_PID}$" | xargs -r kill -9 2>/dev/null || true
    
    if [ "$ACTION" != "init" ]; then
        notify-send -h string:x-canonical-private-synchronous:osd \
                    -u low "Wallpaper Changed" "$(basename "$TARGET_WP")"
    fi
fi
