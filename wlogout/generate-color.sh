#!/bin/bash

# Fichiers
BASE="$HOME/.config/wlogout/style-base.css"
WAL="$HOME/.cache/wal/colors.css"
FINAL="$HOME/.config/wlogout/style.css"

# Concaténer les couleurs de wal en haut du fichier
cat "$WAL" "$BASE" > "$FINAL"
