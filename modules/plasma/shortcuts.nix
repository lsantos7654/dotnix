{ ... }:
{
  flake.modules.homeManager.plasma = {
    programs.plasma.shortcuts = {
      kwin = {
        # Vim-style window focus
        "Switch Window Left" = "Meta+H";
        "Switch Window Down" = "Meta+J";
        "Switch Window Up" = "Meta+K";
        "Switch Window Right" = "Meta+L";

        # Desktop switching
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
        "Switch to Desktop 10" = "Meta+0";

        # Switch desktop directionally
        "Switch One Desktop to the Left" = "Meta+Shift+H";
        "Switch One Desktop to the Right" = "Meta+Shift+L";

        # Move window to adjacent desktops
        "Window One Desktop to the Left" = "Meta+Ctrl+H";
        "Window One Desktop to the Right" = "Meta+Ctrl+L";

        # Move window to specific desktop
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+@";
        "Window to Desktop 3" = "Meta+#";
        "Window to Desktop 4" = "Meta+$";
        "Window to Desktop 5" = "Meta+%";
        "Window to Desktop 6" = "Meta+^";
        "Window to Desktop 7" = "Meta+&";
        "Window to Desktop 8" = "Meta+*";
        "Window to Desktop 9" = "Meta+(";
        "Window to Desktop 10" = "Meta+)";

        # Move window between screens
        "Window One Screen to the Left" = "Ctrl+Alt+H";
        "Window One Screen to the Right" = "Ctrl+Alt+L";
        "Window One Screen Up" = "Ctrl+Alt+K";
        "Window One Screen Down" = "Ctrl+Alt+J";

        # Window management
        "Window Close" = "Meta+Q";
        "Window Minimize" = "Meta+M";

        # Overview / grid
        "Overview" = "Meta+W";

        # Walk through windows
        "Walk Through Windows" = "Meta+Tab";
        "Walk Through Windows (Reverse)" = "Meta+Shift+Tab";
      };

      # KRunner
      "org.kde.krunner.desktop" = {
        _launch = "Search,Alt+Space,Alt+F2";
        RunClipboard = "Alt+Shift+F2";
      };

      # Session management
      ksmserver = {
        "Lock Session" = "Meta+Esc";
        "Log Out" = [ ];
      };

      # Media controls
      mediacontrol = {
        playpausemedia = "Meta+/";
        nextmedia = "Meta+.";
        previousmedia = "Meta+,";
        mediavolumeup = "Meta+=";
        mediavolumedown = "Meta+-";
      };

      # Hardware volume keys
      kmix = {
        increase_volume = "Volume Up";
        decrease_volume = "Volume Down";
        mute = "Volume Mute";
        increase_microphone_volume = "Microphone Volume Up";
        decrease_microphone_volume = "Microphone Volume Down";
        mic_mute = "Meta+Volume Mute,Microphone Mute";
      };

      # Spectacle (screenshots)
      "org.kde.spectacle.desktop" = {
        ActiveWindowScreenShot = "Meta+Shift+P";
        RectangularRegionScreenShot = "Meta+P";
      };

      # Accessibility
      kaccess = {
        "Toggle Screen Reader On and Off" = "Meta+Alt+S";
      };

      # Managed by plasma-manager to clear stale widget shortcut entries on rebuild.
      # PlasMusic shortcut is set via Shortcuts.global in panels.nix.
      plasmashell = { };
    };

    # Application hotkeys
    programs.plasma.hotkeys.commands = {
      "launch-kitty" = {
        name = "Launch Kitty";
        key = "Meta+T";
        command = "kitty";
      };
      "launch-dolphin" = {
        name = "Launch Dolphin";
        key = "Meta+E";
        command = "dolphin";
      };
      "launch-firefox" = {
        name = "Launch Firefox";
        key = "Meta+F";
        command = "firefox";
      };
      "launch-btop" = {
        name = "Launch btop";
        key = "Meta+B";
        command = "kitty btop";
      };
      "logout-no-confirm" = {
        name = "Log Out (No Confirm)";
        key = "Meta+Shift+Esc";
        command = "qdbus6 org.kde.Shutdown /Shutdown logout";
      };
    };
  };
}
