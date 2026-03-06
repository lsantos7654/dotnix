{ config, lib, pkgs, inputs, ... }:

let
  packages = import ../../shared/packages.nix { inherit pkgs; };
in
{
  imports = [
    inputs.home-manager-kde5.nixosModules.home-manager
  ];

  # Home Manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.santos = {
      imports = [
        inputs.dothome-kde5.homeModules.default
        ./plasma
      ];
      home.username = "santos";
      home.homeDirectory = "/home/santos";
      home.stateVersion = lib.mkForce "23.11";
    };
    backupFileExtension = "backup";
    sharedModules = [
      inputs.plasma-manager-kde5.homeManagerModules.plasma-manager
    ];
  };

  # Graphics (23.11 option name)
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  # Plasma 5
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";
  services.xserver.desktopManager.plasma5.enable = true;

  # NVIDIA open drivers not supported on 23.11
  hardware.nvidia.open = lib.mkForce false;

  # Steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  # Fonts (23.11 syntax)
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  # System packages
  environment.systemPackages = packages.core ++ packages.gaming ++ (with pkgs; [
    kate
    papirus-icon-theme
  ]);

  system.stateVersion = lib.mkForce "24.05";
}
