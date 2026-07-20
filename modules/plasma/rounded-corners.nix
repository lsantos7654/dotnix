{ ... }:
{
  flake.modules.homeManager.plasma = {
    programs.plasma.configFile.kwinrc = {
      Plugins.shapecornersEnabled = true;
      "Round-Corners" = {
        Size = 12;
        ActiveSecondOutlinePalette = 16;
        DisableOutlineFullScreen = true;
        DisableOutlineMaximize = true;
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
