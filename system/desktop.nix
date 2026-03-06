{ ... }:

{
  # Display / Desktop
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

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
