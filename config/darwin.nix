{ config, pkgs, ... }:

let
  callPackage = pkgs.callPackage;

  # hammerspoon = callPackage /b/src/apps/hammerspoon.nix { };

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

  # environment.systemPackages = with pkgs; [
  #   discount
  #   emacsGit
  #   fd
  #   fontconfig # to make doom doctor work
  #   git
  #   ctags
  #   # hammerspoon
  #   htop
  #   jq
  #   nixfmt
  #   ripgrep
  #   # ruby_2_6
  #   ruby
  #   shadowenv
  #   shellcheck
  #   tree
  #   zsh
  # ];

  # environment.shells = [ pkgs.zsh ];

  # environment.variables = {
  #   EDITOR = "vim";
  # };

  # programs.nix-index.enable = true;

  # system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  # system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  # system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  # system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;

  system.defaults.dock.autohide = true;
  # system.defaults.dock.orientation = "right";
  system.defaults.dock.showhidden = true;
  # system.defaults.dock.mru-spaces = false;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToControl = true;

  environment.darwinConfig = "/Users/aqua0210/src/nix/config/darwin.nix";

  system.stateVersion = 4;
  nix.maxJobs = 8;
  nix.buildCores = 4;
}
