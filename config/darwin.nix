{ config, pkgs, ... }:

let home = builtins.getEnv "HOME";

in {
  imports = [ <home-manager/nix-darwin> ];

  nix = {
    package = pkgs.nix;
    useDaemon = false;

    # https://github.com/LnL7/nix-darwin/issues/145
    nixPath = pkgs.lib.mkForce [{
      darwin-config = builtins.concatStringsSep ":" [
        "$HOME/src/nix/config/darwin.nix"
        "$HOME/.nix-defexpr/channels"
      ];
    }];

    maxJobs = 16;
    buildCores = 4;
  };

  services = {
    nix-daemon.enable = false;
    activate-system.enable = true;
  };

  programs = { zsh.enable = true; };

  users.users.aqua0210 = {
    home = "/Users/aqua0210";
    description = "Eason Huang";
    shell = pkgs.zsh;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowInsecure = false;
      allowUnsupportedSystem = false;
    };

    overlays = [
      (import (builtins.fetchTarball {
        url =
          "https://github.com/nix-community/emacs-overlay/archive/4581d299be409e326a661bb2c4fdd9842e87b94a.tar.gz";
        sha256 = "04pypybjkrq3bzcbkhmbyb0s1nwsxy1yzgnzyz24k7lr6hkcidvy";
      }))
      (import ../overlays/00-nix-scripts.nix)
    ];
  };

  home-manager = {
    # useUserPackages = true;
    useGlobalPkgs = true;
    users.aqua0210 = { imports = [ ./home.nix ]; };
  };

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        # AppleKeyboardUIMode = 3;
        # ApplePressAndHoldEnabled = false;
        # InitialKeyRepeat = 10;
        # KeyRepeat = 1;
        # _HIHideMenuBar = true;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;

        "com.apple.keyboard.fnState" = true;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = "0.0";
        "com.apple.sound.beep.feedback" = 0;
      };

      ".GlobalPreferences" = {
        "com.apple.sound.beep.sound" = "/System/Library/Sounds/Funk.aiff";
      };

      dock = {
        autohide = true;
        showhidden = true;
        launchanim = false;
        # orientation = "right";
      };

      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };

    };

    # keyboard = {
    #   enableKeyMapping = true;
    #   remapCapsLockToControl = true;
    # };
  };

  environment = {
    darwinConfig = "${home}/src/nix/config/darwin.nix";

  };

}
