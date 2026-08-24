{ user, ... }:

{
  # Nix is expected to be installed and maintained separately, for example by
  # Determinate Nix. This keeps nix-darwin from taking over the Nix daemon.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = user;
  users.users.${user} = {
    home = "/Users/${user}";
  };
  system.stateVersion = 6;

  # These values reflect the current machine. Light appearance is macOS's
  # default when AppleInterfaceStyle is absent, so it is intentionally unset.
  system.defaults = {
    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      _HIHideMenuBar = false;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      "com.apple.keyboard.fnState" = true;
    };

    dock = {
      autohide = true;
      orientation = "right";
    };

    finder = {
      FXPreferredViewStyle = "Nlsv";
      FXDefaultSearchScope = "SCcf";
      CreateDesktop = true;
      ShowPathbar = false;
      ShowStatusBar = false;
    };

    trackpad = {
      Clicking = true;
      Dragging = false;
      TrackpadThreeFingerDrag = true;
    };
  };

  nix-homebrew = {
    enable = true;
    autoMigrate = true;
    inherit user;
  };

  homebrew = {
    enable = true;
    inherit user;

    taps = [
    ];

    # Keep the first migration non-destructive. Once the inventory is reviewed,
    # cleanup can be changed to "zap" if strict Homebrew ownership is desired.
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = false;
    };

    brews = [
      "go"
      "openssh"
    ];

    casks = [
      "claude-code"
      "codex"
      "discord"
      "element"
      "ghostty"
      "gitbutler"
      "keepassxc"
      "openemu"
      "orbstack"
      "rectangle"
      "retroarch"
      "transmission"
      "vlc"
      "wireshark-app"
    ];
  };
}
