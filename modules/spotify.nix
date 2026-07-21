{ ... }:
{
  flake.modules.homeManager.spotify = { pkgs, ... }: {
    xdg.desktopEntries.spotify = {
      name = "Spotify";
      exec = "chromium --app=https://open.spotify.com";
      icon = "chromium";
      type = "Application";
      categories = [ "Audio" "AudioVideo" ];
      comment = "Spotify Web Player";
    };
  };
}