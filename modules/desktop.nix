{ ... }:
{
  flake.modules.nixos.desktop = { lib, pkgs, ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        kde-rounded-corners = prev.kde-rounded-corners.overrideAttrs (old: {
          version = "0.9.0";
          src = prev.fetchFromGitHub {
            owner = "matinlotfali";
            repo = "KDE-Rounded-Corners";
            rev = "v0.9.0";
            hash = "sha256-JZlrjVjA2OGZhWpkSYvwYpPx4tmqlMvi4cP4zM4hxFc=";
          };
          patches = [];
        });
      })
    ];

    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # KDE Rounded Corners — KWin effect plugin
    environment.systemPackages = [ pkgs.kde-rounded-corners ];
    environment.sessionVariables.QT_PLUGIN_PATH = [
      "${pkgs.kde-rounded-corners}/lib/qt-6/plugins"
    ];

    services.xserver.xkb.layout = "us";
    services.printing.enable = true;

    qt = {
      enable = true;
      style = "kvantum";
      platformTheme = "kde";
    };

    programs.kdeconnect.enable = true;

    programs.steam = lib.mkIf pkgs.stdenv.hostPlatform.isx86_64 {
      enable = true;
      gamescopeSession.enable = true;
    };
    hardware.steam-hardware.enable = lib.mkIf pkgs.stdenv.hostPlatform.isx86_64 true;
  };
}
