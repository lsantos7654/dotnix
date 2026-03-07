{ pkgs, ... }:

{
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

    # KDE Plasma extras
    papirus-icon-theme
    plasmusic-toolbar

    # Apps
    spotify
  ];
}
