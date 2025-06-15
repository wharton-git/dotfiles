killall waybar

if [[ $USER == "xeon" ]]
then
    waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css
fi