{ ... }:

{
  programs.plasma.workspace = {
    lookAndFeel = "org.kde.breezedark.desktop";
    iconTheme = "Papirus-Dark";
    cursor = {
      theme = "breeze_cursors";
      size = 24;
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

    scripts.polonium = {
      enable = true;
      settings = {
        borderVisibility = "noBorderTiled";
        layout.engine = "binaryTree";
      };
    };
  };

  # KWin extra settings
  programs.plasma.configFile."kwinrc"."Windows"."RollOverDesktops" = true;
  programs.plasma.configFile."kwinrc"."Windows"."FocusPolicy" = "FocusFollowsMouse";
  programs.plasma.configFile."kwinrc"."Plugins"."diminactiveEnabled" = true;
  programs.plasma.configFile."kwinrc"."Plugins"."virtualdesktopsonlyonprimaryEnabled" = true;
  programs.plasma.configFile."kwinrc"."Plugins"."kwin4_effect_geometry_changeEnabled" = true;
}
