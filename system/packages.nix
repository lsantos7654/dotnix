{ pkgs, ... }:

{
  programs.zsh.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

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

    # KDE Plasma extras
    papirus-icon-theme
    plasmusic-toolbar
    kdePackages.krohnkite

    # Gaming
    mangohud
    protonup-qt

    # Apps
    spotify
  ];
}
