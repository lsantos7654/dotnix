{ inputs, ... }:
{
  flake.modules.nixos.asahi = { lib, pkgs, ... }: {
    imports = [ inputs.apple-silicon.nixosModules.apple-silicon-support ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = false;

    hardware.asahi.enable = true;
    home-manager.users.santos.programs.neovim.enable = lib.mkForce false;

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
