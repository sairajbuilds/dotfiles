{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # Core
    git
    gh
    curl
    wget
    unzip
    zip
    rsync

    # Search & CLI
    ripgrep
    fd
    fzf
    jq
    yq
    tree
    eza
    bat
    zoxide
    fastfetch
    bottom
    just

    # Git
    lazygit
    git-lfs
    delta

    # Editor
    neovim

    # Terminal
    tmux
    starship

    # Languages
    nodejs_24
    bun
    python313
    uv

    jdk21
    maven
    gradle

    rustup

    go

    # Containers
    docker-client
    docker-compose

    # Utils
    imagemagick
    ffmpeg

    # Nix
    nil
    nixfmt

    # Shell
    direnv
    nix-index

    # Archives
    p7zip

    # Networking
    httpie

    # JSON
    fx

    # Process inspection
    procs
    dust

    # macOS utilities
    mas

    # Utilities
    hyperfine
    tokei

  ];
}
