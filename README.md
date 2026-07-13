# dotfiles

My personal NixOS development environment on Apple Silicon.

This branch documents the migration from Fedora Asahi to **NixOS** on the same M2 MacBook Air — a fully declarative, reproducible system configuration running GNOME on top of the Asahi Linux kernel.

---

## Hardware

- MacBook Air M2 (Apple Silicon)
- 8 GB RAM

---

## Operating System

- NixOS 25.11 (Xantusia)
- Linux 6.17.7 (Asahi kernel, via `nixos-apple-silicon`)
- GNOME (Wayland)
- Boot chain: m1n1 + U-Boot (UEFI environment, dual-booting macOS)

---

## Philosophy

- Declarative over imperative — the entire system lives in `configuration.nix`
- Reproducible — rebuild the exact same machine from one file
- Atomic upgrades — every change is a new generation; rollback is trivial
- Terminal-first, GUI where it earns its place
- Optimize for not fighting the OS — GNOME + `power-profiles-daemon` over hand-rolled tiling WM power tuning

This setup trades some of the deep customizability of my old Hyprland rice for the reliability and reproducibility NixOS gives me by default.

---

## Development Stack

### Editors
- Neovim (LazyVim)
- VSCodium

### Terminal
- Kitty
- tmux
- Starship prompt

### Languages / Toolchains
- Flutter (git-cloned SDK, not Nix-packaged — better Android build compatibility)
- Java (OpenJDK 21)
- Python (pyenv)
- Ruby (rbenv)
- Node.js (nvm)
- Rust (planned — not yet in active use)

### Version Control
- Git
- lazygit
- SSH (ed25519)

### CLI
- ripgrep, fd, fzf, zoxide, bat, eza, fastfetch

### Browsers
- Zen Browser (via community Nix overlay, not in official nixpkgs)
- Brave
- Firefox — not used

---

## System-Level Notes (NixOS + Apple Silicon specifics)

A few non-obvious things this setup depends on, documented here so future-me doesn't have to rediscover them:

- **`programs.nix-ld.enable = true;`** — required for any non-Nix-native dynamically linked binary to run (Flutter's bundled Dart SDK, in particular)
- **`PKG_CONFIG_PATH`** must be manually exported in `.bashrc` — Nix's `pkg-config` wrapper doesn't automatically search the system profile's `lib/pkgconfig`
- **GTK3 dev headers** need explicit `.dev` outputs (`gtk3.dev`, `pango.dev`, `cairo.dev`, etc.) for Flutter Linux desktop builds to find them via `pkg-config`
- **`JAVA_HOME`** is resolved dynamically (`$(dirname $(dirname $(readlink -f $(which java))))`) since Nix's store paths aren't stable across rebuilds
- **`adb` does not run** — Google ships `platform-tools` as x86_64-only; no official ARM64 build exists. Android device/emulator testing happens via macOS dual-boot instead; `flutter run -d linux` is the primary local dev loop
- **NextDNS + DNS-over-TLS** via `systemd-resolved`, with NetworkManager's per-connection DNS explicitly disabled (`main.dns = "none"` + `ignore-auto-dns` per connection) so it doesn't override the global resolver with router-provided DNS
- **Marathi ITRANS input** via IBus + m17n (`m17n:mr:itrans`), added directly via `gsettings` since GNOME Settings' UI didn't reliably persist it

---

## Repository Structure

```text
dotfiles/
├── kitty/
├── nvim/
├── .bashrc
├── .tmux.conf
├── starship.toml
└── README.md
```

(Hyprland-era configs — `hypr/`, `waybar/`, `quickshell/`, `matugen/` — intentionally excluded from this branch; they remain on `master` for the Fedora/Hyprland setup.)

---

## Installation

```bash
git clone https://github.com/sairajbuilds/dotfiles.git ~/dotfiles
git -C ~/dotfiles checkout nixos-rebuild

ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/kitty ~/.config/kitty
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml

source ~/.bashrc
```

System-level packages, GNOME, and hardware support live in `/etc/nixos/configuration.nix` on the machine itself (not version-controlled in this repo yet — a good next step).

---

## Future Plans

- Version-control `/etc/nixos/configuration.nix` itself
- Migrate to flakes for fully pinned reproducibility
- Disk encryption (deliberately skipped on this install — would require a reinstall)
- Investigate ARM64 `adb` alternatives

---

## History

This repository started as a Fedora Asahi Linux configuration focused on Hyprland and a terminal-first workflow, later branched into a macOS environment (`macos-rebuild`), and now includes this NixOS-on-Apple-Silicon setup — same machine, same goals of reproducibility and reliability, different OS each time.

---

## License

MIT
