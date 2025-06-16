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

# generate colors with wal
wal -i "$SELECTED"

# Generate color scheme for waybar
sassc ~/.config/hypr/waybar/style-base.scss ~/.config/hypr/waybar/style.css

# Set the wallpaper using swww
swww img "$SELECTED" --transition-type any --transition-duration 0.6

# Generate color scheme for wlogout
sassc ~/.config/wlogout/style-base.scss ~/.config/wlogout/style.css

# Reload waybar if it's running
killall waybar

if [[ $USER == "xeon" ]]
then
    waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css
fi

echo "$SELECTED" > "$LAST_WALL"
