{
  description = "NixOS configuration for santos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    dothome = {
      url = "github:lsantos7654/dothome";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, dothome, ... }@inputs:
  let
    system = "x86_64-linux";
    overlay-kde-rounded-corners = final: prev: {
      kde-rounded-corners = prev.kde-rounded-corners.overrideAttrs (old: {
        patches = (old.patches or []) ++ [
          ./patches/kde-rounded-corners-kwin-region.patch
        ];
      });
    };
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.overlays = [ overlay-kde-rounded-corners ]; }
        ./configuration.nix
      ];
    };
  };
}
