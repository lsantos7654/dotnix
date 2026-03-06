{ pkgs, config, ... }:

let
  wallpaperDir = "${config.home.homeDirectory}/wallpapers";
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

  # Activate theme via plasma-manager
  programs.plasma.workspace = {
    lookAndFeel = "Ant-Dark";
    colorScheme = "Ant-Dark";
    theme = "Ant-Dark";
    iconTheme = "Ant-Dark";
    cursorTheme = "breeze_cursors";
  };

  # Options not available in plasma-5 branch — use configFile
  programs.plasma.configFile.kdeglobals.General.widgetStyle = "kvantum-dark";
  programs.plasma.configFile.kcminputrc.Mouse.cursorSize = 24;
  programs.plasma.configFile.kwinrc."org.kde.kdecoration2" = {
    library = "org.kde.kwin.aurorae";
    theme = "__aurorae__svg__Ant-Dark";
  };

  programs.plasma.kwin = {
    virtualDesktops = {
      names = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
      rows = 1;
    };
  };

  # Options not available in plasma-5 branch — use configFile
  programs.plasma.configFile.kwinrc.Windows.BorderlessMaximizedWindows = true;
  programs.plasma.configFile.kwinrc.Plugins = {
    blurEnabled = false;
    translucencyEnabled = true;
    glideEnabled = true;
    magiclampEnabled = true;
    slideEnabled = false;
    diminactiveEnabled = true;
    virtualdesktopsonlyonprimaryEnabled = true;
    krohnkiteEnabled = true;
  };

  # KWin extra settings
  programs.plasma.configFile.kwinrc.Windows.RollOverDesktops = true;
  programs.plasma.configFile.kwinrc.Windows.FocusPolicy = "FocusFollowsMouse";
  programs.plasma.configFile.kwinrc."Effect-diminactive".Strength = 40;

  # Spanning wallpaper (split into 3x 2560x1440 per monitor)
  home.file."wallpapers/left.jpg".source = ../../../shared/wallpapers/left.jpg;
  home.file."wallpapers/center.jpg".source = ../../../shared/wallpapers/center.jpg;
  home.file."wallpapers/right.jpg".source = ../../../shared/wallpapers/right.jpg;
  programs.plasma.configFile.plasmarc.Wallpapers.usersWallpapers = "${wallpaperDir}/left.jpg,${wallpaperDir}/center.jpg,${wallpaperDir}/right.jpg";
  programs.plasma.configFile.kwinrc."Script-krohnkite" = {
    directionalKeyFocus = false;
    floatUtility = true;
    layoutPerActivity = false;
    layoutPerDesktop = false;
    monocleMaximize = false;
    noTileBorder = true;
    screenGapBetween = 5;
    screenGapBottom = 5;
    screenGapLeft = 5;
    screenGapRight = 5;
    screenGapTop = 5;
  };
}
