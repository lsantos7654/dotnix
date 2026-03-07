{ ... }:
{
  flake.modules.nixos.hardware = { config, pkgs, ... }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

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

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
