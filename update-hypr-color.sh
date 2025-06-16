#!/bin/bash

# Charge les couleurs générées par wal
source "$HOME/.cache/wal/colors.sh"

# Couleurs personnalisées à partir de wal
ACTIVE_BORDER_START="$color1"
ACTIVE_BORDER_END="$color2"
INACTIVE_BORDER="$color8"

# Fichier de config final généré
TEMPLATE="$HOME/.config/hypr/hyprland.conf.template"
OUTPUT="$HOME/.config/hypr/hyprland.conf"

# Remplace les variables dans le template
sed -e "s|{active_border_start}|rgba(${ACTIVE_BORDER_START:1}ee)|g" \
    -e "s|{active_border_end}|rgba(${ACTIVE_BORDER_END:1}ee)|g" \
    -e "s|{inactive_border}|rgba(${INACTIVE_BORDER:1}aa)|g" \
    "$TEMPLATE" > "$OUTPUT"

# Recharge Hyprland config (optionnel mais recommandé)
hyprctl reload
