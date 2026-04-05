#!/bin/bash
sleep 2
killall waybar 2>/dev/null
waybar -c "$HOME/.config/waybar/configs/[TOP] Sleek" -s "$HOME/.config/waybar/style/[Dark] Half-Moon.css"
