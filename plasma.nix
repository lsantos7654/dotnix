{ pkgs, ... }:

{
  programs.plasma.enable = true;
  programs.plasma.overrideConfig = true;
  # ============================================================================
  # WORKSPACE / THEME
  # ============================================================================
  programs.plasma.workspace = {
    lookAndFeel = "org.kde.breezedark.desktop";
    iconTheme = "Papirus-Dark";
    cursor = {
      theme = "breeze_cursors";
      size = 24;
    };
  };

  # ============================================================================
  # KWIN
  # ============================================================================
  programs.plasma.kwin = {
    borderlessMaximizedWindows = true;

    effects = {
      blur = {
        enable = true;
        strength = 8;
        noiseStrength = 3;
      };
      translucency.enable = true;
      desktopSwitching.animation = "slide";
      windowOpenClose.animation = "glide";
      minimization.animation = "magiclamp";
    };

    virtualDesktops = {
      names = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
      rows = 1;
    };

    scripts.polonium = {
      enable = true;
      settings = {
        borderVisibility = "noBorderTiled";
        layout.engine = "binaryTree";
      };
    };
  };

  # ============================================================================
  # SHORTCUTS
  # ============================================================================
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

      # Move window to specific desktop (Meta+Shift+number)
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
      "Window No Border" = "Meta+Backspace";

      # Overview / grid
      "Overview" = "Meta+W";
      "ShowDesktopGrid" = "Meta+Shift+W";

      # Walk through windows
      "Walk Through Windows" = "Meta+Tab";
      "Walk Through Windows (Reverse)" = "Alt+Shift+Backtab";
      "Walk Through Windows of Current Application" = "Alt+`";
      "Walk Through Windows of Current Application (Reverse)" = "Alt+~";

      # Zoom
      "view_zoom_in" = "Meta++";
    };

    # KRunner
    "org.kde.krunner.desktop" = {
      _launch = "Search,Alt+Space,Alt+F2";
      RunClipboard = "Alt+Shift+F2";
    };

    # Session management
    ksmserver = {
      "Lock Session" = "Meta+Esc";
      "Log Out" = "Ctrl+Alt+Del";
    };

    # Media controls
    mediacontrol = {
      playpausemedia = "Media Play,Meta+/";
      nextmedia = "Media Next,Meta+.";
      previousmedia = "Meta+,,Media Previous";
      pausemedia = "Media Pause";
      stopmedia = "Media Stop";
      mediavolumeup = "Meta+=,Meta+Num++";
      mediavolumedown = "Meta+Num+-,Meta+-";
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
      _launch = "Print";
      ActiveWindowScreenShot = "Meta+Print";
      FullScreenScreenShot = "Shift+Print";
      RectangularRegionScreenShot = "Meta+P,Meta+Shift+Print";
      WindowUnderCursorScreenShot = "Meta+Ctrl+Print";
    };

    # Accessibility
    kaccess = {
      "Toggle Screen Reader On and Off" = "Meta+Alt+S";
    };
  };

  # ============================================================================
  # APPLICATION HOTKEYS
  # ============================================================================
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
  };

  # ============================================================================
  # PANEL — single top bar
  # ============================================================================
  programs.plasma.panels = [
    {
      location = "top";
      screen = 0;
      height = 32;
      floating = false;
      alignment = "center";
      hiding = "normalpanel";
      widgets = [
        "org.kde.plasma.kickoff"
        {
          iconTasks = {
            launchers = [
              "applications:kitty.desktop"
              "applications:org.kde.dolphin.desktop"
              "applications:firefox.desktop"
            ];
          };
        }
        "org.kde.plasma.panelspacer"
        {
          digitalClock = {
            date.enable = true;
            time.format = "24h";
          };
        }
        "org.kde.plasma.panelspacer"
        "plasmusic-toolbar"
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

  # ============================================================================
  # KVANTUM THEME
  # ============================================================================
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=KvGnomeDark
  '';
}
