{ ... }:
{
  flake.modules.homeManager.plasma = {
    programs.plasma.configFile.kwinrc = {
      Plugins.shapecornersEnabled = true;
      "Effect-shapecorners".CornerRadius = 8;
      "Round-Corners" = {
        ActiveSecondOutlinePalette = 16;
        DisableOutlineFullScreen = false;
        DisableOutlineMaximize = false;
        DisableOutlineTile = false;
        DisableRoundFullScreen = false;
        DisableRoundMaximize = false;
        DisableRoundTile = false;
        OutlineColor = "0,0,255";
        OutlineThickness = 2;
      };
    };
  };
}
