#!/usr/bin/env bash

set -euo pipefail

echo "Configuring zsh..."

ln -sf "$PWD/config/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/config/zsh/.zprofile" "$HOME/.zprofile"

echo "Done."