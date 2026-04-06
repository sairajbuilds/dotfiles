# Dotfiles

Personal Linux configuration for a terminal-first workflow on **Fedora Asahi (Apple Silicon)** using **Hyprland**, **tmux**, and **Neovim**.

The goal of this setup is simple:

* Fast startup
* Minimal friction
* Reproducible environment
* Keyboard-driven workflow
* Stable daily development machine

---

## System Overview

**Hardware**

* MacBook Air M2 (Apple Silicon)
* 8 GB RAM

**Operating System**

* Fedora Asahi Linux
* Wayland
* Hyprland

**Core Philosophy**

* Terminal as the control center
* Minimal GUI dependency
* Predictable workspace
* Persistent sessions
* Simple, maintainable configuration

---

## Key Tools

### Shell

* bash
* zoxide — smart directory navigation
* fzf — fuzzy search
* ripgrep — fast search

### Terminal Workflow

* tmux — session and window management
* tmux-resurrect — session persistence
* tmux-continuum — automatic save/restore

### Editor

* Neovim
* LSP support
* File explorer
* Git integration

### Version Control

* git
* lazygit

### Window Manager

* Hyprland

---

## Repository Structure

```
dotfiles/
├── bash/
│   └── .bashrc
├── tmux/
│   └── .tmux.conf
├── nvim/
│   └── init.lua
├── hypr/
│   └── hyprland.conf
├── scripts/
│   ├── proj
│   ├── newproj
│   └── status
└── README.md
```

---

## Core Workflow

### Start a Project

```
proj project-name
```

This command:

* Creates or attaches to a tmux session
* Opens project directory
* Starts editor
* Opens git interface
* Restores previous session if available

Workspace layout:

```
1 shell
2 editor
3 build
4 git
```

---

### Navigate Quickly

```
z project
zz
```

Directory navigation becomes instant as usage history grows.

---

### Create a New Project

```
newproj project-name
```

Creates:

```
project/
├── contracts/
├── scripts/
├── test/
└── README.md
```

---

### System Check

```
status
```

Shows:

* Disk usage
* Memory usage
* Uptime

---

## Daily Workflow

Morning:

```
proj my-project
```

Work:

* Write code in Neovim
* Run builds in tmux
* Manage git via lazygit

Shutdown:

```
poweroff
```

Next boot:

```
proj my-project
```

Workspace resumes automatically.

---

## Installation

Clone the repository:

```
git clone https://github.com/sairaj15/dotfiles.git
cd dotfiles
```

Link configuration files:

```
ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/hypr ~/.config/hypr
```

Reload shell:

```
source ~/.bashrc
```

---

## Design Principles

* Prefer simplicity over cleverness
* Avoid unnecessary dependencies
* Keep configuration readable
* Optimize for daily reliability
* Make recovery easy

---

## Why These Dotfiles Exist

This setup was built to support:

* Software development
* Blockchain / Web3 development
* Terminal-centric workflow
* Low-distraction computing
* Consistent daily environment

---

## Notes

* Designed primarily for Fedora Asahi and ARM systems
* Should work on most modern Linux distributions
* GUI tools are optional
* Terminal workflow is the default

---

## License

MIT
