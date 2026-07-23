{ ... }:
let
  inputactions-kwin-pkg = { stdenv
  , cmake
  , extra-cmake-modules
  , fetchFromGitHub
  , kglobalacceld
  , kwin
  , libevdev
  , pkg-config
  , qttools
  , wrapQtAppsHook
  , yaml-cpp
  }:
  stdenv.mkDerivation {
    pname = "inputactions-kwin";
    version = "0.9.0.0";

    src = fetchFromGitHub {
      owner = "InputActions";
      repo = "kwin";
      rev = "4c672d124b2bc3e36909570492ec6f3b18915158";
      hash = "sha256-CxWRjBRZ8ZFTUGZpTnLFnguGRz2xkxYzAXYuGW9b7vQ=";
      fetchSubmodules = true;
    };

    nativeBuildInputs = [
      cmake
      extra-cmake-modules
      wrapQtAppsHook
    ];

    buildInputs = [
      kwin
      qttools
      libevdev
      kglobalacceld
      pkg-config
      yaml-cpp
    ];

    postInstall = "";  # keep in effects/plugins/ — this is a KWin Effect, not a Plugin
  };
in
{
  flake.modules.nixos.kwin = {
    nixpkgs.overlays = [(final: prev: {
      kdePackages = prev.kdePackages.overrideScope (kfinal: kprev: {
        inputactions-kwin = kfinal.callPackage inputactions-kwin-pkg { };
      });
    })];
  };

  flake.modules.homeManager.plasma = { pkgs, ... }:
  let
    kwin-geometry-change = pkgs.fetchFromGitHub {
      owner = "peterfajdiga";
      repo = "kwin4_effect_geometry_change";
      rev = "v1.5";
      hash = "sha256-p4FpqagR8Dxi+r9A8W5rGM5ybaBXP0gRKAuzigZ1lyA=";
    };

    # KWin script: pins windows on non-primary outputs to all desktops
    # (GNOME-style "workspaces on primary display only")
    virtual-desktops-only-on-primary = pkgs.fetchFromGitHub {
      owner = "Ubiquitine";
      repo = "virtual-desktops-only-on-primary";
      rev = "fa1d87953cbc6d923fdcd59a057d69100ef92784";
      hash = "sha256-znOsncV+otIh9idoqP+l1gFZ9Nem2AVCoy8Eg0v+NqU=";
    };
  in
  {
    xdg.dataFile."kwin/effects/kwin4_effect_geometry_change" = {
      source = "${kwin-geometry-change}/package";
      recursive = true;
    };

    xdg.dataFile."kwin/scripts/virtual-desktops-only-on-primary" = {
      source = virtual-desktops-only-on-primary;
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
      Windows.FocusPolicy = "FocusFollowsMouse";
      "Effect-diminactive".Strength = 40;
      Plugins."virtual-desktops-only-on-primaryEnabled" = true;
      Plugins.kwin4_effect_geometry_changeEnabled = true;
      Plugins.kwin_gesturesEnabled = true;
      "Effect-overview".BorderActivate = 9;
    };
  };
}