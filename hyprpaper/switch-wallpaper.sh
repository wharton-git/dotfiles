#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

LAST_WALL="$HOME/.config/hypr/.last_wallpaper"

if ! pgrep -x "hyprpaper" > /dev/null; then
    echo "Erreur : hyprpaper n'est pas lancé !"
    exit 1
fi

readarray -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | sort)

TOTAL=${#WALLPAPERS[@]}
if [ "$TOTAL" -eq 0 ]; then
    echo "Aucun fond d'écran trouvé dans $WALLPAPER_DIR"
    exit 1
fi

PREV=""
[ -f "$LAST_WALL" ] && PREV=$(cat "$LAST_WALL")

SELECTED=""
while [[ "$SELECTED" == "" || "$SELECTED" == "$PREV" ]]; do
    RANDOM_INDEX=$((RANDOM % TOTAL))
    SELECTED="${WALLPAPERS[$RANDOM_INDEX]}"
done

MONITOR_NAME="eDP-1"

hyprctl hyprpaper preload "$SELECTED"
hyprctl hyprpaper wallpaper "$MONITOR_NAME,$SELECTED"

echo "$SELECTED" > "$LAST_WALL"
