#!/bin/bash
WALLPAPER="$1"

if [ -z "$WALLPAPER" ]; then
  echo "Usage: wallpaper.sh <path-to-image>"
  exit 1
fi

swww img "$WALLPAPER" --transition-type grow --transition-pos 0.5,0.5 --transition-duration 1
matugen image "$WALLPAPER"
echo "$WALLPAPER" > ~/.config/hypr/.current_wallpaper
