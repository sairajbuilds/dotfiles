#!/usr/bin/env bash

mkdir -p "$HOME/.config/ghostty"

ln -sf "$PWD/config/ghostty/config" \
       "$HOME/.config/ghostty/config"