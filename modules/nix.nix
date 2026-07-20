{ ... }:

{
  nix = {
    enable = false;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
    };
  };
}
