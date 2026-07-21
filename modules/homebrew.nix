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
      "navidrome"
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
      "signal"
      "appflowy"
      "super-productivity"
      "logseq"
      "tailscale-app"
      "musicbrainz-picard"
      "proton-drive"
      "proton-pass"
      "protonvpn"
      "jordanbaird-ice"
    ];
  };
}
