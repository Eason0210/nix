{
  description = "Nix system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/0a9e90389a5ec16788322974587ec154ea810270";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, ... }:
    let
      inherit (darwin.lib) darwinSystem;

      mkDarwinConfig =
        { system ? "x86_64-darwin"
        , nixpkgs ? inputs.nixpkgs
        , baseModules ? [
            home-manager.darwinModules.home-manager
            ./config/darwin.nix
          ]
        , extraModules ? [ ]
        }:
        darwinSystem {
          inherit system;
          modules = baseModules ++ extraModules;
        };
    in
    {
      darwinConfigurations = {
        MacBook = mkDarwinConfig {
          extraModules = [ ];
        };
      };
    };
}
