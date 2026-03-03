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

      # Move window to adjacent desktops
      "Window to Desktop Left" = "Meta+Ctrl+H";
      "Window to Desktop Right" = "Meta+Ctrl+L";

      # Window management
      "Window Close" = "Meta+Q";
      "Window Maximize" = "Meta+Up";
      "Window Minimize" = "Meta+Down";
      "Window No Border" = "Meta+Backspace";

      # Overview / grid
      "Overview" = "Meta+W";
      "Show Desktop Grid" = "Meta+Shift+W";

      # Walk through windows
      "Walk Through Windows" = "Meta+Tab";
    };

    # KRunner
    "org.kde.krunner.desktop"._launch = "Alt+Space";

    # Media controls (group/action names may need adjustment after first build)
    mediacontrol = {
      playpausemedia = "Meta+/";
      nextmedia = "Meta+.";
      previousmedia = "Meta+,";
    };

    # Volume
    kmix = {
      increase_volume = "Meta+=";
      decrease_volume = "Meta+-";
    };
  };

  # ============================================================================
  # SPECTACLE (screenshots)
  # ============================================================================
  programs.plasma.spectacle.shortcuts = {
    captureEntireDesktop = "Print";
    captureActiveWindow = "Meta+Print";
    launch = "Meta+P";
    captureRectangularRegion = "Meta+Shift+S";
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
    "launch-obsidian" = {
      name = "Launch Obsidian";
      key = "Meta+O";
      command = "obsidian";
    };
  };

  # ============================================================================
  # PANEL — single top bar
  # ============================================================================
  programs.plasma.panels = [
    {
      location = "top";
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
