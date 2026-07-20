{ ... }:

{
  nix.enable = false;

  system.stateVersion = 6;

  system.primaryUser = "sairajsawant";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.sairajsawant = {
    home = "/Users/sairajsawant";
  };

  environment.systemPath = [
    "/opt/homebrew/bin"
  ];

  programs.zsh.enable = true;
}
