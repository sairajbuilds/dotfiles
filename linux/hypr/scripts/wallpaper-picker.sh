#!/bin/bash

WALLPAPER_DIR="$HOME/Wallpapers"
ICON_DIR="$HOME/.local/share/icons/wallpapers/256x256/apps"

SELECTED=$(for img in "$WALLPAPER_DIR"/*; do
    name=$(basename "$img")
    stem=$(basename "$img" | sed 's/\.[^.]*$//')
    echo -en "$name\0icon\x1f$ICON_DIR/$stem.png\n"
done | rofi -dmenu -p "🖼 Wallpaper" -i \
    -theme-str 'element-icon { size: 150px; }' \
    -theme-str 'listview { columns: 3; lines: 3; }')

[ -z "$SELECTED" ] && exit

~/.config/hypr/scripts/wallpaper.sh "$WALLPAPER_DIR/$SELECTED"
