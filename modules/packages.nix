{ ... }:
{
  flake.modules.nixos.packages = { pkgs, ... }: {
    programs.zsh.enable = true;

    fonts.packages = with pkgs; [
      nerd-fonts.hack
    ];

    environment.systemPackages = with pkgs; [
      # Core tools
      vim
      git
      gh
      curl
      wget
      (btop.override { cudaSupport = true; })
      htop
      claude-code
      alsa-utils

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
