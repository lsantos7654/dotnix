{ ... }:
{
  flake.modules.homeManager.plasma = { config, ... }:
  let
    wallpaperDir = "${config.home.homeDirectory}/wallpapers";
  in
  {
    home.file."wallpapers/left.jpg".source = ../../wallpapers/left.jpg;
    home.file."wallpapers/center.jpg".source = ../../wallpapers/center.jpg;
    home.file."wallpapers/right.jpg".source = ../../wallpapers/right.jpg;

    programs.plasma.workspace.wallpaper = [
      "${wallpaperDir}/center.jpg"
      "${wallpaperDir}/right.jpg"
      "${wallpaperDir}/left.jpg"
    ];
  };
}
