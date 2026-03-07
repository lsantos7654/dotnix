{ ... }:
{
  flake.modules.nixos.desktop = { pkgs, ... }: {
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

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    hardware.steam-hardware.enable = true;
  };
}
