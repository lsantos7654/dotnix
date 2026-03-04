{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
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
      ];
      home.username = "santos";
      home.homeDirectory = "/home/santos";
    };
    backupFileExtension = "backup";
    sharedModules = [
      inputs.plasma-manager.homeModules.plasma-manager
    ];
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel (better for new hardware like RTX 50 series)
  boot.kernelPackages = pkgs.linuxPackages_6_18;

  # ACPI fix for ASUS Z690-E board
  boot.kernelParams = [
    "acpi_osi=!"
    ''acpi_osi="Windows 2022"''
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Display / Desktop
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;  # REQUIRED for RTX 50 series
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Graphics / OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Keyboard
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing
  services.printing.enable = true;

  # Audio (PipeWire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Shell
  programs.zsh.enable = true;

  # Passwordless sudo for wheel group
  security.sudo.wheelNeedsPassword = false;

  # User account
  users.users.santos = {
    isNormalUser = true;
    description = "Lucas Santos";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  # Applications
  programs.firefox.enable = true;
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

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    btop
    gh
    wget
    curl
    htop
    claude-code
    kdePackages.kate
    mangohud
    protonup-qt

    # KDE Plasma extras
    papirus-icon-theme
    plasmusic-toolbar
    polonium
  ];

  system.stateVersion = "25.11";
}
