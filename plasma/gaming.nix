{ pkgs, ... }:

let
  gaming-mode-toggle = pkgs.writeShellApplication {
    name = "gaming-mode-toggle";
    runtimeInputs = with pkgs; [ kdePackages.qttools libnotify ];
    text = ''
      STATE_FILE="''${XDG_RUNTIME_DIR}/gaming-mode-active"

      # Find the kwinrulesrc group number for "Transparent Windows" rule
      find_transparent_rule_group() {
        local i=1
        while true; do
          desc=$(kreadconfig6 --file kwinrulesrc --group "$i" --key Description 2>/dev/null)
          if [ -z "$desc" ]; then
            break
          fi
          if [ "$desc" = "Transparent Windows" ]; then
            echo "$i"
            return
          fi
          i=$((i + 1))
        done
        echo ""
      }

      if [ -f "$STATE_FILE" ]; then
        # === Exit gaming mode ===
        rm "$STATE_FILE"

        # Restore opacity rule to 85%
        RULE_GROUP=$(find_transparent_rule_group)
        if [ -n "$RULE_GROUP" ]; then
          kwriteconfig6 --file kwinrulesrc --group "$RULE_GROUP" --key opacityactive 85
          kwriteconfig6 --file kwinrulesrc --group "$RULE_GROUP" --key opacityinactive 85
        fi

        # Re-enable dim inactive
        kwriteconfig6 --file kwinrc --group Plugins --key diminactiveEnabled true

        # Re-enable translucency
        kwriteconfig6 --file kwinrc --group Plugins --key translucencyEnabled true

        # Reconfigure KWin
        qdbus org.kde.KWin /KWin reconfigure

        notify-send "Gaming Mode" "OFF — Effects restored" --icon=applications-games
      else
        # === Enter gaming mode ===
        touch "$STATE_FILE"

        # Set opacity rule to 100%
        RULE_GROUP=$(find_transparent_rule_group)
        if [ -n "$RULE_GROUP" ]; then
          kwriteconfig6 --file kwinrulesrc --group "$RULE_GROUP" --key opacityactive 100
          kwriteconfig6 --file kwinrulesrc --group "$RULE_GROUP" --key opacityinactive 100
        fi

        # Disable dim inactive
        kwriteconfig6 --file kwinrc --group Plugins --key diminactiveEnabled false

        # Disable translucency
        kwriteconfig6 --file kwinrc --group Plugins --key translucencyEnabled false

        # Reconfigure KWin
        qdbus org.kde.KWin /KWin reconfigure

        notify-send "Gaming Mode" "ON — Effects disabled" --icon=applications-games
      fi
    '';
  };
in
{
  home.packages = [ gaming-mode-toggle ];

  # Meta+G hotkey
  programs.plasma.hotkeys.commands."gaming-mode-toggle" = {
    name = "Toggle Gaming Mode";
    key = "Meta+G";
    command = "gaming-mode-toggle";
  };

  # Gamescope window rule — always active
  programs.plasma.window-rules = [
    {
      description = "Gamescope Fullscreen";
      match = {
        window-class = {
          value = "gamescope";
          type = "substring";
        };
      };
      apply = {
        position = { value = "0,0"; apply = "force"; };
        size = { value = "7680,1440"; apply = "force"; };
        above = { value = true; apply = "force"; };
        noborder = { value = true; apply = "force"; };
        opacityactive = { value = 100; apply = "force"; };
        opacityinactive = { value = 100; apply = "force"; };
      };
    }
  ];
}
