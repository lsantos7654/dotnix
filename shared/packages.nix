{ pkgs }:

{
  core = with pkgs; [
    vim
    git
    btop
    gh
    wget
    curl
    htop
  ];

  gaming = with pkgs; [
    mangohud
    protonup-qt
  ];
}
