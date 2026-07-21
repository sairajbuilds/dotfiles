# dotfiles

My declarative macOS development environment for Apple Silicon, built with **nix-darwin**, **Home Manager**, and **Homebrew**.

The goal of this repository is simple: configure my entire development machine from code and make it reproducible on a fresh Mac with a single rebuild.

---

## Hardware

- MacBook Air M2 (Apple Silicon)
- 8 GB RAM

---

## Operating System

- macOS
- nix-darwin
- Home Manager
- Homebrew (managed declaratively by nix-darwin)

---

## Philosophy

- Declarative over imperative
- Reproducible system configuration
- Terminal-first workflow
- Native macOS experience instead of fighting the platform
- Keep machine configuration separate from project configuration

This repository manages the machine—not individual projects. Projects are created using the standard tooling provided by their respective ecosystems (`flutter create`, `npm`, Spring Initializr, `forge init`, etc.).

---

## Development Environment

### Editors

- Neovim (LazyVim)
- VSCodium

### Terminal

- Ghostty
- tmux
- Starship

### Languages & Toolchains

- Flutter
- Dart
- Java 21
- Node.js 24
- Bun
- Python 3.13
- Go
- Rust
- Maven
- Gradle

### Version Control

- Git
- Git LFS
- lazygit
- GitHub CLI

### CLI Tools

- ripgrep
- fd
- fzf
- eza
- bat
- zoxide
- jq
- yq
- just
- fastfetch
- bottom
- dust
- httpie

---

## Managed Applications

Installed declaratively through Homebrew:

- Ghostty
- Raycast
- Android Studio
- OrbStack
- Stats
- LinearMouse
- Mullvad Browser
- VSCodium

---

## Repository Structure

```text
dotfiles/
├── flake.nix
├── flake.lock
├── hosts/
├── home/
├── modules/
├── nvim/
├── kitty/
├── starship.toml
└── README.md
```

---

## Installation

```bash
git clone https://github.com/sairajbuilds/dotfiles.git ~/dotfiles

cd ~/dotfiles

sudo darwin-rebuild switch --flake .
```

---

## Future Improvements

- Support additional Macs through `hosts/`
- Modularize configurations further
- Add CI to validate the flake
- Add automated bootstrap documentation

---

## License

MIT
