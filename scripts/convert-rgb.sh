#!/bin/bash

# Check if a file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 colors.scss"
    exit 1
fi

INPUT="$1"
OUTPUT="$HOME/.config/hypr/base/colors-rgb.scss"

# Create output directory if it doesn't exist
mkdir -p "$(dirname "$OUTPUT")"

# Empty the output file
> "$OUTPUT"

# Table pour stocker les couleurs $color3 à $color7
declare -A base_colors

# Read file line by line
while IFS= read -r line; do
    if [[ "$line" =~ ^(\$[a-zA-Z0-9_-]+):[[:space:]]*#([0-9a-fA-F]{6}) ]]; then
        var="${BASH_REMATCH[1]}"
        hex="${BASH_REMATCH[2]}"
        r=$((16#${hex:0:2}))
        g=$((16#${hex:2:2}))
        b=$((16#${hex:4:2}))
        echo "$var: rgb($r, $g, $b);" >> "$OUTPUT"

        # Stocker color3 à color7 pour usage ultérieur
        case "$var" in
            \$color3|\$color4|\$color5|\$color6|\$color7)
                base_colors["$var"]="$r,$g,$b"
                ;;
        esac
    else
        echo "$line" >> "$OUTPUT"
    fi
done < "$INPUT"

# Ajouter color16 à color20 avec transparence
echo "" >> "$OUTPUT"

index=16
for i in {3..7}; do
    key="\$color$i"
    if [[ -n "${base_colors[$key]}" ]]; then
        echo "\$color$index: rgba(${base_colors[$key]}, 0.7);" >> "$OUTPUT"
        ((index++))
    fi
done

echo "✅ File converted: $OUTPUT"
