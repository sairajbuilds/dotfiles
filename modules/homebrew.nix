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
      "stats"
      "linearmouse"
      "mullvad-browser"
      "vscodium"
      "alt-tab"
    ];
  };
}
