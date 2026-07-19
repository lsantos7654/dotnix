{ ... }:
{
  flake.modules.homeManager.plasma = {
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
              behavior.grouping.method = "none";
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
              };
            };
          }
          {
            digitalClock = {
              date.enable = true;
              time.format = "12h";
            };
          }
          {
            systemTray = {
              items.shown = [
                "org.kde.plasma.volume"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.battery"
                "org.kde.plasma.clipboard"
              ];
              items.hidden = [
                "org.kde.plasma.notifications"
                "org.kde.plasma.mediacontroller"
                "org.kde.plasma.printmanager"
                "org.kde.plasma.devicenotifier"
              ];
            };
          }
        ];
      }
    ];
  };
}
