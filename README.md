# dotfiles

My personal macOS development environment.

This repository bootstraps my entire development workstation from a clean macOS installation. It installs development tools, configures macOS, and manages application configuration so a new machine can be ready in minutes.

---

## Hardware

- MacBook Air M2 (Apple Silicon)
- 8 GB RAM

---

## Operating System

- macOS
- Homebrew
- zsh

---

## Philosophy

This setup is designed around a few simple principles.

- Reproducible
- Keyboard-friendly
- Minimal maintenance
- Fast to rebuild
- Optimized for software development

I don't optimize for having the most customized system. I optimize for spending the least time maintaining my computer and the most time building software.

---

## Development Stack

### Editors

- VSCodium
- Cursor
- Neovim

### Terminal

- Ghostty

### Languages

- Flutter
- Dart
- Java
- Node.js
- Go
- Rust
- Python

### Version Control

- Git
- GitHub CLI
- LazyGit

### CLI

- ripgrep
- fd
- bat
- eza
- fzf
- zoxide
- yazi
- jq
- fastfetch

---

## Applications

### Development

- Android Studio
- Xcode

### Browsers

- Zen Browser
- Brave

### Productivity

- Obsidian
- Logseq
- Signal
- Telegram
- LocalSend
- VLC

---

## Repository Structure

```text
dotfiles/
├── Brewfile
├── install.sh
├── config/
│   ├── nvim/
│   └── kitty/
├── macos/
├── scripts/
├── docs/
└── legacy/
```

---

## Installation

```bash
git clone git@github.com:sairajbuilds/dotfiles.git

cd dotfiles

./install.sh
```

---

## Goals

- One-command setup
- Version controlled configuration
- Easy migration to a new machine
- Consistent development environment

---

## Future Plans

- Automated macOS preferences
- Flutter setup
- Android SDK configuration
- Git configuration
- SSH configuration
- Dock and Finder automation
- Development environment health checks

---

## History

This repository originally started as a Fedora Asahi Linux configuration focused on Hyprland and a terminal-first workflow. It has since evolved into a reproducible macOS development environment while preserving the same goals of simplicity, reliability, and reproducibility.

---

## License

MIT