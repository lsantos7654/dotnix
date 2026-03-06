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
    btop
    htop
    claude-code

    # KDE Plasma extras
    papirus-icon-theme
    plasmusic-toolbar
    kdePackages.krohnkite
    kde-rounded-corners

    # Gaming
    mangohud
    protonup-qt

    # Apps
    spotify
  ];
}
