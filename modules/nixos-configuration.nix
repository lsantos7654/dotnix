{ config, ... }:
let
  inherit (config.flake.modules) nixos;
in
{
  configurations.nixos.nixos.module = {
    imports = [
      ../hardware-configuration.nix
      nixos.overlay
      nixos.hardware
      nixos.networking
      nixos.locale
      nixos.nix-settings
      nixos.audio
      nixos.desktop
      nixos.packages
      nixos.tiling
      nixos.user
    ];

    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = config.stateVersion;
  };
}
