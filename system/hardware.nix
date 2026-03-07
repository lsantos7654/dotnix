{ config, pkgs, ... }:

{
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

  # NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true; # REQUIRED for RTX 50 series
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Graphics / OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

}
