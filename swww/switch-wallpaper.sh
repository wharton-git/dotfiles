#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

LAST_WALL="$HOME/.config/hypr/swww/.last_wallpaper"

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

# generate colors with wal
wal -i "$SELECTED"

bash ~/.config/hypr/scripts/convert-rgb.sh ~/.cache/wal/colors.scss

# Set the wallpaper using swww
swww img "$SELECTED" --transition-type any --transition-duration 0.6

# Generate color scheme for waybar
sassc ~/.config/hypr/waybar/style-base.scss ~/.config/hypr/waybar/style.css

# Ipdate color scheme for hypr
bash ~/.config/hypr/update-hypr-color.sh

# Generate color scheme for wlogout
sassc ~/.config/wlogout/style-base.scss ~/.config/wlogout/style.css

# Reload waybar if it's running
killall waybar

if [[ $USER == "xeon" ]]
then
    waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css
fi

echo "$SELECTED" > "$LAST_WALL"
