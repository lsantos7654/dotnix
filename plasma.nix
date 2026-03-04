{ pkgs, ... }:

let
  kwin-geometry-change = pkgs.fetchFromGitHub {
    owner = "peterfajdiga";
    repo = "kwin4_effect_geometry_change";
    rev = "v1.5";
    hash = "sha256-p4FpqagR8Dxi+r9A8W5rGM5ybaBXP0gRKAuzigZ1lyA=";
  };
in
{
  # Install Geometry Change KWin effect
  xdg.dataFile."kwin/effects/kwin4_effect_geometry_change" = {
    source = "${kwin-geometry-change}/package";
    recursive = true;
  };
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
      desktopSwitching.animation = "off";
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

  # KWin: desktop navigation wraps around
  programs.plasma.configFile."kwinrc"."Windows"."RollOverDesktops" = true;

  # KWin: focus follows mouse
  programs.plasma.configFile."kwinrc"."Windows"."FocusPolicy" = "FocusFollowsMouse";

  # KWin: dim inactive windows
  programs.plasma.configFile."kwinrc"."Plugins"."diminactiveEnabled" = true;

  # KWin: virtual desktops only affect primary screen
  programs.plasma.configFile."kwinrc"."Plugins"."virtualdesktopsonlyonprimaryEnabled" = true;

  # KWin: geometry change animation for scripted/tiled window moves
  programs.plasma.configFile."kwinrc"."Plugins"."kwin4_effect_geometry_changeEnabled" = true;

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

      # Vim-style window moving
      "PoloniumInsertAbove" = "Meta+Alt+K";
      "PoloniumInsertBelow" = "Meta+Alt+J";
      "PoloniumInsertLeft" = "Meta+Alt+H";
      "PoloniumInsertRight" = "Meta+Alt+L";

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
      "Log Out" = "Ctrl+Alt+Del";
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
      # _launch = "Print";
      ActiveWindowScreenShot = "Meta+Shift+P";
      # FullScreenScreenShot = "Meta+Shift+P";
      RectangularRegionScreenShot = "Meta+P";
      # WindowUnderCursorScreenShot = "Meta+Ctrl+Print";
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
  # WINDOW RULES
  # ============================================================================
  programs.plasma.window-rules = [
    {
      description = "transparent windows";
      match = {
        window-types = [
          "normal"
          "toolbar"
          "torn-of-menu"
          "dialog"
          "menubar"
          "utility"
          "osd"
        ];
      };
      apply = {
        activeOpacity = { value = 90; apply = "force"; };
        inactiveOpacity = { value = 90; apply = "force"; };
      };
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
