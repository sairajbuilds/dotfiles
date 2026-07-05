#!/usr/bin/env bash

set -euo pipefail

echo "Configuring Git..."

ln -sf "$PWD/config/git/.gitconfig" "$HOME/.gitconfig"
ln -sf "$PWD/config/git/.gitignore_global" "$HOME/.gitignore_global"

echo "Git configured."