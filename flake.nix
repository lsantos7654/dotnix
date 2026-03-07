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
        version = "0.8.6-unstable-2025-12-19";
        src = prev.fetchFromGitHub {
          owner = "matinlotfali";
          repo = "KDE-Rounded-Corners";
          rev = "876a88188c819b080db8fc3d0f36ecff8fdbec42";
          hash = "sha256-gwsGQxBvZzgsSsMoN5rgDyyjxL/fNAtYwLgfxcKj5lk=";
        };
      });
    };
    overlays = [ overlay-kde-rounded-corners ];
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.overlays = overlays; }
        ./configuration.nix
      ];
    };
  };
}
