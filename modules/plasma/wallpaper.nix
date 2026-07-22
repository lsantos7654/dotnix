{ ... }:
{
  flake.modules.homeManager.plasma = { config, pkgs, ... }:
  let
    wallpaperDir = "${config.home.homeDirectory}/wallpapers";
    videoPlugin = "luisbocanegra.smart.video.wallpaper.reborn";
    activeVideo = "forest"; # change to "milky-way" to switch
    videoPluginConfig = {
      General = {
        VideoUrls = builtins.toJSON [
          {
            filename = "file://${wallpaperDir}/videos/${activeVideo}.mp4";
            enabled = true;
            loop = true;
          }
        ];
        Volume = 0.0;
        ResumeLastVideo = false;
        CrossfadeEnabled = true;
        CrossfadeDuration = 3000;
      };
    };
  in
  {
    home.file."wallpapers/left.jpg".source = ../../wallpapers/left.jpg;
    home.file."wallpapers/center.jpg".source = ../../wallpapers/center.jpg;
    home.file."wallpapers/right.jpg".source = ../../wallpapers/right.jpg;
    home.file."wallpapers/videos/forest.mp4".source = ../../wallpapers/videos/forest.mp4;
    home.file."wallpapers/videos/milky-way.mp4".source = ../../wallpapers/videos/milky-way.mp4;
    home.file."wallpapers/videos/forest-preview.jpg".source = ../../wallpapers/videos/forest-preview.jpg;
    home.file."wallpapers/videos/milky-way-preview.jpg".source = ../../wallpapers/videos/milky-way-preview.jpg;

    programs.plasma = pkgs.lib.mkMerge [
      (pkgs.lib.mkIf pkgs.stdenv.hostPlatform.isx86_64 {
        workspace.wallpaper = [
          "${wallpaperDir}/center.jpg"
          "${wallpaperDir}/right.jpg"
          "${wallpaperDir}/left.jpg"
        ];
      })
      (pkgs.lib.mkIf pkgs.stdenv.hostPlatform.isAarch64 {
        workspace.wallpaperCustomPlugin = {
          plugin = videoPlugin;
          config = videoPluginConfig;
        };
        # Static frame of the active video so the lock screen matches the desktop
        kscreenlocker.appearance.wallpaper = "${wallpaperDir}/videos/${activeVideo}-preview.jpg";
      })
    ];
  };
}
