{ ... }:

{
  programs.plasma.panels = [
    {
      location = "top";
      screen = 0;
      height = 32;
      alignment = "center";
      hiding = "none";
      widgets = [
        {
          name = "org.kde.plasma.pager";
          config.General = {
            showOnlyCurrentScreen = "true";
            showWindowIcons = "true";
            wrapPage = "true";
          };
        }
        {
          name = "org.kde.plasma.icontasks";
          config.General.launchers = "";
        }
        "org.kde.plasma.panelspacer"
        {
          digitalClock = {
            date.enable = true;
            time.format = "12h";
          };
        }
        "org.kde.plasma.panelspacer"
        {
          systemTray = {
            items.shown = [
              "org.kde.plasma.volume"
              "org.kde.plasma.networkmanagement"
              "org.kde.plasma.bluetooth"
              "org.kde.plasma.battery"
            ];
            items.hidden = [
              "org.kde.plasma.clipboard"
              "org.kde.plasma.notifications"
              "org.kde.plasma.printmanager"
              "org.kde.plasma.devicenotifier"
            ];
          };
        }
      ];
    }
  ];
}
