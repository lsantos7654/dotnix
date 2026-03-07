{ pkgs, ... }:

let
  ant-dark-kde = pkgs.fetchFromGitHub {
    owner = "EliverLara";
    repo = "Ant";
    rev = "f7ae9ea39379290cb2319ea2c313cab409e8c1dc";
    hash = "sha256-sIXEG7QDtSH1ogHG0v97Z+R6YApxs2xtZFWJQ38L1T8=";
  };
in
{
  # Install Ant Dark theme assets
  xdg.dataFile."aurorae/themes/Ant-Dark" = {
    source = "${ant-dark-kde}/kde/Dark/aurorae/Ant-Dark";
    recursive = true;
  };

  xdg.dataFile."color-schemes/Ant-Dark.colors" = {
    source = "${ant-dark-kde}/kde/Dark/color-schemes/Ant-Dark.colors";
  };

  xdg.dataFile."icons/Ant-Dark" = {
    source = "${ant-dark-kde}/kde/Dark/icons/Ant-Dark";
    recursive = true;
  };

  xdg.dataFile."plasma/desktoptheme/Ant-Dark" = {
    source = "${ant-dark-kde}/kde/Dark/plasma/desktoptheme/Ant-Dark";
    recursive = true;
  };

  xdg.dataFile."plasma/look-and-feel/Ant-Dark" = {
    source = "${ant-dark-kde}/kde/Dark/plasma/look-and-feel/Ant-Dark";
    recursive = true;
  };

  xdg.configFile."Kvantum/Ant-Dark" = {
    source = "${ant-dark-kde}/kde/Dark/kvantum/Ant-Dark";
    recursive = true;
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Ant-Dark
  '';

  programs.plasma.configFile = {
    kdeglobals.WM.frame = "61,174,233";
    kdeglobals.WM.inactiveFrame = "74,74,74";
  };

  # Activate theme via plasma-manager
  programs.plasma.workspace = {
    colorScheme = "Ant-Dark";
    theme = "Ant-Dark";
    iconTheme = "Ant-Dark";
    widgetStyle = "kvantum-dark";
    cursor = {
      theme = "breeze_cursors";
      size = 24;
    };
    windowDecorations = {
      library = "org.kde.kdecoration2";
      theme = "Breeze";
    };
  };
}
