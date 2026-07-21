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

      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;    
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = false;

      FXPreferredViewStyle = "Nlsv";

      ShowPathbar = true;
      ShowStatusBar = true;

      FXEnableExtensionChangeWarning = false;
    };

    dock = {
      autohide = true;
      tilesize = 52;
      show-recents = false;
      expose-group-apps = true;
      mineffect = "genie";
      mru-spaces = false;

      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
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
