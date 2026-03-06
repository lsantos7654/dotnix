{ ... }:

{
  programs.plasma.panels = [
    {
      location = "top";
      screen = 0;
      height = 32;
      floating = false;
      alignment = "center";
      hiding = "normalpanel";
      widgets = [
        {
          pager = {
            general = {
              showOnlyCurrentScreen = true;
              showApplicationIconsOnWindowOutlines = true;
              navigationWrapsAround = true;
            };
          };
        }
        {
          iconTasks = {
            launchers = [];
          };
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
          plasmusicToolbar = {
            settings = {
              General = {
                iconInPanel = false;
                playPauseControlInPanel = false;
                skipBackwardControlInPanel = false;
                skipForwardControlInPanel = false;
              };
              Shortcuts = {
                global = "Meta+\\";
              };
            };
          };
        }
        {
          systemTray = {
            items.shown = [
              "org.kde.plasma.volume"
              "org.kde.plasma.networkmanagement"
              "org.kde.plasma.bluetooth"
            ];
            items.hidden = [
              "org.kde.plasma.battery"
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
