#!/usr/bin/env bash

# Minimalist wallpaper switcher and loader using swaybg

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CURRENT_WP_FILE="$HOME/.config/hypr/current_wallpaper"

mkdir -p "$WALLPAPER_DIR"

ACTION="${1:-next}"

if [ "$ACTION" == "init" ]; then
    # Load previously saved wallpaper or fallback to default
    if [ -f "$CURRENT_WP_FILE" ] && [ -f "$(cat "$CURRENT_WP_FILE")" ]; then
        TARGET_WP="$(cat "$CURRENT_WP_FILE")"
    else
        TARGET_WP="$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) 2>/dev/null | head -n 1)"
    fi
else
    # Pick a random wallpaper
    mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) 2>/dev/null)
    
    if [ ${#WALLPAPERS[@]} -eq 0 ]; then
        notify-send -u low "Wallpaper" "No wallpapers found in ~/Pictures/Wallpapers/"
        exit 1
    fi
    
    TARGET_WP="${WALLPAPERS[RANDOM % ${#WALLPAPERS[@]}]}"
fi

if [ -n "$TARGET_WP" ] && [ -f "$TARGET_WP" ]; then
    echo "$TARGET_WP" > "$CURRENT_WP_FILE"
    
    # Spawn new swaybg instance before killing old for seamless transition
    swaybg -i "$TARGET_WP" -m fill &
    NEW_PID=$!
    sleep 0.2
    
    # Kill any older swaybg instances
    pgrep -x swaybg | grep -v "^${NEW_PID}$" | xargs -r kill -9 2>/dev/null || true
    
    if [ "$ACTION" != "init" ]; then
        notify-send -h string:x-canonical-private-synchronous:osd \
                    -u low "Wallpaper Changed" "$(basename "$TARGET_WP")"
    fi
fi
