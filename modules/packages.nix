{ ... }:
{
  flake.modules.nixos.packages = { lib, pkgs, ... }: {
    programs.zsh.enable = true;

    fonts.packages = with pkgs; [
      nerd-fonts.hack
    ];

    environment.systemPackages = with pkgs; [
      # Core tools
      vim
      git
      gh
      clang
      curl
      wget
      htop
      btop
      alsa-utils

    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
      # KDE Plasma extras
      papirus-icon-theme
      plasmusic-toolbar

      # Gaming
      mangohud
      protonup-qt
      steamtinkerlaunch
      discord

      # Apps
      spotify
    ];
  };
}
