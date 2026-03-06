{ ... }:

{
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
  ];
}
