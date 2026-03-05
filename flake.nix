{
  description = "NixOS configuration for santos";

  inputs = {
    # KDE6 (nixos-unstable)
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

    # KDE5 (nixos-23.11 — last release with Plasma 5.27.11)
    nixpkgs-kde5.url = "github:NixOS/nixpkgs/205fd4226592cc83fd4c0885a3e4c9c400efabb5";
    home-manager-kde5 = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-kde5";
    };
    plasma-manager-kde5 = {
      url = "github:nix-community/plasma-manager/plasma5";
      inputs.nixpkgs.follows = "nixpkgs-kde5";
      inputs.home-manager.follows = "home-manager-kde5";
    };
    dothome-kde5 = {
      url = "github:lsantos7654/dothome";
      inputs.nixpkgs.follows = "nixpkgs-kde5";
      inputs.home-manager.follows = "home-manager-kde5";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-kde5, ... }@inputs:
  let
    system = "x86_64-linux";
    overlay-kde-rounded-corners = final: prev: {
      kde-rounded-corners = prev.kde-rounded-corners.overrideAttrs (old: {
        patches = (old.patches or []) ++ [
          ./desktops/kde6/patches/kde-rounded-corners-kwin-region.patch
        ];
      });
    };
  in
  {
    nixosConfigurations.nixos-kde6 = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.overlays = [ overlay-kde-rounded-corners ]; }
        ./shared/hardware-configuration.nix
        ./shared/system.nix
        ./desktops/kde6
      ];
    };

    nixosConfigurations.nixos-kde5 = nixpkgs-kde5.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./shared/hardware-configuration.nix
        ./shared/system.nix
        ./desktops/kde5
      ];
    };
  };
}
