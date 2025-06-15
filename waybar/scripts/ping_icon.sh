#!/bin/bash

ping_result=$(ping -c 1 -w 1 8.8.8.8 | grep 'time=' | awk -F'time=' '{print $2}' | cut -d ' ' -f1)

# fallback si ping échoue
if [ -z "$ping_result" ]; then
    icon="󰩠"  # icône "pas de réseau"
    color="#FF0000"
    ping=999
else
    ping=$(printf "%.0f" "$ping_result")

    if [ "$ping" -lt 50 ]; then
        icon="󰢾"  # Très bon ping
        color="#00FF00"
    elif [ "$ping" -lt 100 ]; then
        icon="󰣀"  # Correct
        color="#FFA500"
    else
        icon="󰢿"  # Mauvais
        color="#FF0000"
    fi
fi

# sortie JSON pour Waybar
echo "{\"text\": \"<span color='$color'>$icon</span>\", \"ping\": \"$ping\"}"
