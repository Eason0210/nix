{ config, pkgs, ... }:

let callPackage = pkgs.callPackage;

in {
  imports = [ <home-manager/nix-darwin> ];

  nix = {
    # Auto upgrade nix package and the daemon service.
    # better not XD
    #  services.nix-daemon.enable = true;
    package = pkgs.nix;

    # https://github.com/LnL7/nix-darwin/issues/145
    # https://github.com/LnL7/nix-darwin/issues/105#issuecomment-567742942
    # fixed according to https://github.com/LnL7/nix-darwin/blob/b3e96fdf6623dffa666f8de8f442cc1d89c93f60/CHANGELOG
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

  services.emacs.package = pkgs.emacsUnstable;

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
          "https://github.com/nix-community/emacs-overlay/archive/e9e6de910fe1a9c485b7a9c3ae321030bfb8cc36.tar.gz";
        sha256 = "1arqmdgkaak6m8gzcf71yqr4smk8abziy84rpb2dkq82023y5d44";
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
    darwinConfig = "/Users/aqua0210/src/nix/config/darwin.nix";

  };

}
