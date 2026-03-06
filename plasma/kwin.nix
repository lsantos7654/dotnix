{ pkgs, ... }:

let
  kwin-geometry-change = pkgs.fetchFromGitHub {
    owner = "peterfajdiga";
    repo = "kwin4_effect_geometry_change";
    rev = "v1.5";
    hash = "sha256-p4FpqagR8Dxi+r9A8W5rGM5ybaBXP0gRKAuzigZ1lyA=";
  };
in
{
  # Install Geometry Change KWin effect
  xdg.dataFile."kwin/effects/kwin4_effect_geometry_change" = {
    source = "${kwin-geometry-change}/package";
    recursive = true;
  };

  programs.plasma.kwin = {
    borderlessMaximizedWindows = true;

    effects = {
      blur.enable = false;
      translucency.enable = true;
      desktopSwitching.animation = "off";
      desktopSwitching.navigationWrapping = true;
      windowOpenClose.animation = "glide";
      minimization.animation = "magiclamp";
      dimInactive.enable = true;
    };

    virtualDesktops = {
      names = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
      rows = 1;
    };

    nightLight = {
      enable = true;
      temperature.night = 6000;
    };
  };

  programs.plasma.configFile.kwinrc = {
    # Focus policy (no high-level option)
    Windows.FocusPolicy = "FocusFollowsMouse";

    # Dim inactive strength (only .enable is exposed)
    "Effect-diminactive".Strength = 40;

    # Virtual desktops only on primary monitor
    Plugins.virtualdesktopsonlyonprimaryEnabled = true;

    # Geometry Change effect
    Plugins.kwin4_effect_geometry_changeEnabled = true;

    # Disable overview hot corner
    "Effect-overview".BorderActivate = 9;

  };
}
