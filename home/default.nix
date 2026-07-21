{ config, ... }:

{
  imports = [
    ./git.nix
    ./shell.nix
    ./starship.nix
    ./tmux.nix
    ./nvim.nix
    ./ghostty.nix
    ./aliases.nix
    ./direnv.nix
    ./functions.nix
  ];

  home.username = "sairajsawant";
  home.homeDirectory = "/Users/sairajsawant";

  home.sessionPath = [
    "/opt/flutter/bin"
  ];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.file.".config/starship.toml".source =
  config.lib.file.mkOutOfStoreSymlink "/Users/sairajsawant/dotfiles/starship.toml";

  home.file.".config/nvim".source =
  config.lib.file.mkOutOfStoreSymlink "/Users/sairajsawant/dotfiles/nvim";
}
