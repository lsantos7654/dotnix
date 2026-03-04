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
  # ── Install Ant Dark theme assets ─────────────────────────────────────────

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

  # ── Activate theme via plasma-manager ─────────────────────────────────────

  programs.plasma.workspace = {
    lookAndFeel = "Ant-Dark";
    colorScheme = "Ant-Dark";
    theme = "Ant-Dark";
    iconTheme = "Ant-Dark";
    widgetStyle = "kvantum-dark";
    cursor = {
      theme = "breeze_cursors";
      size = 24;
    };
    windowDecorations = {
      library = "org.kde.kwin.aurorae";
      theme = "__aurorae__svg__Ant-Dark";
    };
  };

  programs.plasma.kwin = {
    borderlessMaximizedWindows = true;

    effects = {
      blur = {
        enable = true;
        strength = 8;
        noiseStrength = 3;
      };
      translucency.enable = true;
      desktopSwitching.animation = "off";
      windowOpenClose.animation = "glide";
      minimization.animation = "magiclamp";
    };

    virtualDesktops = {
      names = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
      rows = 1;
    };

  };

  # KWin extra settings
  programs.plasma.configFile.kwinrc.Windows.RollOverDesktops = true;
  programs.plasma.configFile.kwinrc.Windows.FocusPolicy = "FocusFollowsMouse";
  programs.plasma.configFile.kwinrc.Plugins.diminactiveEnabled = true;
  programs.plasma.configFile.kwinrc."Effect-diminactive".Strength = 40;
  programs.plasma.configFile.kwinrc.Plugins.virtualdesktopsonlyonprimaryEnabled = true;
  programs.plasma.configFile.kwinrc.Plugins.kwin4_effect_geometry_changeEnabled = true;

  # KDE Rounded Corners
  programs.plasma.configFile.kwinrc.Plugins.shapecornersEnabled = true;
  programs.plasma.configFile.kwinrc."Effect-shapecorners".CornerRadius = 8;

  # Krohnkite tiling script
  programs.plasma.configFile.kwinrc.Plugins.krohnkiteEnabled = true;
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
