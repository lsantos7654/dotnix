{ ... }:

{
  # Fix PlasMusic widget shortcut after panel rebuild.
  # The panel script (priority 2) recreates panels with new widget IDs, but kglobalaccel
  # holds stale registrations that conflict. This script runs after (priority 3) to clean
  # up stale entries, register the correct shortcut, and force kglobalaccel to reload.
  programs.plasma.startup.startupScript."plasmusic-shortcut" = {
    text = ''
      sleep 2

      APPLETS_FILE="$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
      if [ -f "$APPLETS_FILE" ]; then
        WIDGET_ID=$(grep -B10 'plugin=plasmusic-toolbar' "$APPLETS_FILE" \
          | grep -oP '(?<=\[Applets\]\[)\d+' | tail -1)
        if [ -n "$WIDGET_ID" ]; then
          sed -i '/activate widget.*Activate PlasMusic Toolbar Widget/d' \
            "$HOME/.config/kglobalshortcutsrc"

          kwriteconfig6 --file kglobalshortcutsrc \
            --group plasmashell \
            --key "activate widget $WIDGET_ID" \
            'Meta+\\,none,Activate PlasMusic Toolbar Widget'

          systemctl --user restart plasma-kglobalaccel
        fi
      fi
    '';
    priority = 3;
    runAlways = true;
  };

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
              "org.kde.plasma.mediacontroller"
              "org.kde.plasma.printmanager"
              "org.kde.plasma.devicenotifier"
            ];
          };
        }
      ];
    }
  ];
}
