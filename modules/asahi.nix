{ inputs, ... }:
{
  flake.modules.nixos.asahi = { pkgs, ... }: {
    imports = [ inputs.apple-silicon.nixosModules.apple-silicon-support ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = false;
    boot.kernelParams = [ "apple_dcp.show_notch=1" ];

    zramSwap.enable = true;
    zramSwap.memoryPercent = 50;

    hardware.asahi.enable = true;

    services.envfs.enable = true;

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
      ];
    };
  };
}
