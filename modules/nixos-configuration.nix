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
    nixos.kwin
    nixos.inputactions
    nixos.user
  ];
in
{
  configurations.nixos.nixos = {
    system = "x86_64-linux";
    module = {
      imports = [
        nixos.hardware-configuration
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
        nixos.asahi-hardware-configuration
        nixos.asahi
      ] ++ commonImports;

      nixpkgs.hostPlatform = "aarch64-linux";
      system.stateVersion = config.stateVersion;
    };
  };
}
