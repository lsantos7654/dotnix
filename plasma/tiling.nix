{ ... }:

{
  programs.plasma.configFile.kwinrc = {
    Plugins.krohnkiteEnabled = true;

    "Script-krohnkite" = {
      binaryTreeLayoutOrder = 0;
      cascadeLayoutOrder = 0;
      columnsLayoutOrder = 0;
      directionalKeyFocus = false;
      floatUtility = true;
      floatingLayoutOrder = 0;
      layoutPerActivity = false;
      layoutPerDesktop = false;
      monocleLayoutOrder = 0;
      monocleMaximize = false;
      noTileBorder = true;
      quarterLayoutOrder = 0;
      screenGapBetween = 5;
      screenGapBottom = 5;
      screenGapLeft = 5;
      screenGapRight = 5;
      screenGapTop = 5;
      spiralLayoutOrder = 0;
      spreadLayoutOrder = 0;
      stackedLayoutOrder = 0;
      stairLayoutOrder = 0;
      threeColumnLayoutOrder = 0;
    };
  };
}
