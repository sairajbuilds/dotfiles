#!/bin/bash
sleep 2
killall waybar 2>/dev/null
nohup waybar -c "/home/sairaj/.config/waybar/configs/[TOP] Matugen" -s "/home/sairaj/.config/waybar/style/[Matugen] Minimal.css" > /dev/null 2>&1 &
disown
