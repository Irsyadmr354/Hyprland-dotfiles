#!/usr/bin/env bash

# Minimalist random / next wallpaper switcher script for Hyprpaper

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Ensure directory exists and has images
if [ ! -d "$WALLPAPER_DIR" ]; then
    mkdir -p "$WALLPAPER_DIR"
fi

# Find image files (jpg, jpeg, png, webp)
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) 2>/dev/null)

if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    notify-send -u low "Wallpaper" "No wallpapers found in ~/Pictures/Wallpapers/"
    exit 1
fi

# Pick random wallpaper
RANDOM_WP="${WALLPAPERS[RANDOM % ${#WALLPAPERS[@]}]}"

# Ensure hyprpaper is running
if ! pgrep -x "hyprpaper" > /dev/null; then
    hyprpaper &
    sleep 0.5
fi

# Apply wallpaper using hyprctl hyprpaper IPC
hyprctl hyprpaper preload "$RANDOM_WP"
hyprctl hyprpaper wallpaper ",$RANDOM_WP"
hyprctl hyprpaper unload all

# Update config so it persists on restart
cat <<EOF > "$HOME/.config/hypr/hyprpaper.conf"
preload = $RANDOM_WP
wallpaper = ,$RANDOM_WP
splash = false
EOF

notify-send -h string:x-canonical-private-synchronous:osd \
            -u low "Wallpaper Changed" "$(basename "$RANDOM_WP")"
