{ config, pkgs, ... }:

{
  launchd.daemons.navidrome = {
    serviceConfig = {
      Label = "org.navidrome.server";

      ProgramArguments = [
        "/opt/homebrew/bin/navidrome"
        "--configfile"
        "/Users/sairajsawant/Music/Navidrome/navidrome.toml"
      ];

      WorkingDirectory = "/Users/sairajsawant/Music/Navidrome";

      RunAtLoad = true;
      KeepAlive = true;

      StandardOutPath = "/Users/sairajsawant/Library/Logs/navidrome.log";
      StandardErrorPath = "/Users/sairajsawant/Library/Logs/navidrome-error.log";
    };
  };
}
