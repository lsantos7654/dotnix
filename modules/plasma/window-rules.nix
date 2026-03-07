{ ... }:
{
  flake.modules.homeManager.plasma = {
    programs.plasma.window-rules = [
      {
        description = "Transparent Windows";
        match = {
          window-types = [ "normal" "dialog" "utility" "toolbar" "torn-of-menu" "dock" "desktop" "spash" ];
        };
        apply = {
          opacityactive = { value = 85; apply = "force"; };
          opacityinactive = { value = 85; apply = "force"; };
        };
      }
      {
        description = "Gamescope Fullscreen";
        match.window-class = { value = "gamescope"; type = "substring"; };
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
  };
}
