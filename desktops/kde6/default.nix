{ config, pkgs, inputs, ... }:

let
  packages = import ../../shared/packages.nix { inherit pkgs; };
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # Home Manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.santos = {
      imports = [
        inputs.dothome.homeModules.default
        ./plasma
        ./firefox
      ];
      home.username = "santos";
      home.homeDirectory = "/home/santos";
    };
    backupFileExtension = "backup";
    sharedModules = [
      inputs.plasma-manager.homeModules.plasma-manager
    ];
  };

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Plasma 6
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_6_18;

  # Applications
  programs.kdeconnect.enable = true;

  # Qt theming via Kvantum
  qt = {
    enable = true;
    style = "kvantum";
    platformTheme = "kde";
  };

  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  hardware.steam-hardware.enable = true;

  # Ensure KWin effect plugins are linked into the system profile
  environment.pathsToLink = [ "/lib/qt-6/plugins/kwin/effects/plugins" ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  # System packages
  environment.systemPackages = packages.core ++ packages.gaming ++ (with pkgs; [
    claude-code
    kdePackages.kate
    papirus-icon-theme
    plasmusic-toolbar
    kdePackages.krohnkite
    kde-rounded-corners
  ]);
}
