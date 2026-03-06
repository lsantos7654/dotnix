{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system/hardware.nix
    ./system/desktop.nix
    ./system/audio.nix
    ./system/packages.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # User account
  users.users.santos = {
    isNormalUser = true;
    description = "Lucas Santos";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  # Home Manager
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
      home.stateVersion = "25.11";
    };
    backupFileExtension = "backup";
    sharedModules = [
      inputs.plasma-manager.homeModules.plasma-manager
    ];
  };

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
