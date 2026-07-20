{ ... }:

{
  system.defaults = {

    NSGlobalDomain = {
      AppleShowAllExtensions = true;

      InitialKeyRepeat = 15;
      KeyRepeat = 2;

      ApplePressAndHoldEnabled = false;

      # Natural scrolling
      "com.apple.swipescrolldirection" = true;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = false;

      FXPreferredViewStyle = "Nlsv";

      ShowPathbar = true;
      ShowStatusBar = true;
    };

    dock = {
      autohide = true;
      tilesize = 52;
      show-recents = false;
      expose-group-apps = true;
      mineffect = "genie";
    };

    screencapture = {
      location = "~/Pictures/Screenshots";
      type = "png";
    };

    menuExtraClock = {
      Show24Hour = false;
      ShowDate = 1;
      ShowDayOfWeek = true;
    };

    trackpad = {
      Clicking = false;
      TrackpadThreeFingerDrag = true;
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;
}
