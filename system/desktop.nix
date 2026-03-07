{ pkgs, ... }:

{
  # Display / Desktop
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # KDE Rounded Corners — KWin effect plugin
  environment.systemPackages = [ pkgs.kde-rounded-corners ];
  environment.sessionVariables.QT_PLUGIN_PATH = [
    "${pkgs.kde-rounded-corners}/lib/qt-6/plugins"
  ];

  # Keyboard
  services.xserver.xkb.layout = "us";

  # Printing
  services.printing.enable = true;

  # Qt theming via Kvantum
  qt = {
    enable = true;
    style = "kvantum";
    platformTheme = "kde";
  };

  # KDE Connect
  programs.kdeconnect.enable = true;
}
