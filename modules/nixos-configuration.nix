{ config, inputs, ... }:
let
  inherit (config.flake.modules) nixos;
  commonImports = [
    nixos.networking
    nixos.locale
    nixos.nix-settings
    nixos.audio
    nixos.desktop
    nixos.packages
    nixos.tiling
    nixos.user
  ];
in
{
  configurations.nixos.nixos = {
    system = "x86_64-linux";
    module = {
      imports = [
        ../hardware-configuration.nix
        nixos.hardware
      ] ++ commonImports;

      nixpkgs.hostPlatform = "x86_64-linux";
      system.stateVersion = config.stateVersion;
    };
  };

  configurations.nixos.asahi = {
    system = "aarch64-linux";
    module = {
      imports = [
        ../asahi-hardware-configuration.nix
        nixos.asahi
      ] ++ commonImports;

      nixpkgs.hostPlatform = "aarch64-linux";
      system.stateVersion = config.stateVersion;
    };
  };
}
