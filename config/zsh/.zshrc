# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Better CLI
export EDITOR="nvim"

# Java
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# Flutter
export PATH="$HOME/Development/Flutter/flutter/bin:$PATH"

# Go
export PATH="$HOME/go/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# fnm (Node.js)
eval "$(fnm env --use-on-cd)"

# Aliases
alias ll="eza -la --icons"
alias ls="eza --icons"
alias cat="bat"
alias lg="lazygit"
alias ff="fastfetch"

# Navigation
eval "$(zoxide init zsh)"

# FZF
source <(fzf --zsh)
