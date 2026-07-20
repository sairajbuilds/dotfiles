{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };

    brews = [
      "mas"
    ];

    casks = [
      "ghostty"
      "raycast"

      "android-studio"

      "orbstack"

      "font-jetbrains-mono-nerd-font"

      "stats"

      "linearmouse"

      "mullvad-browser"
    ];
  };
}
