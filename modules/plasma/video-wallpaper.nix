{ ... }:
{
  flake.modules.nixos.video-wallpaper = { pkgs, ... }: {
    environment.systemPackages = [
      (pkgs.runCommand "smart-video-wallpaper" {} ''
        mkdir -p $out/share/plasma/wallpapers
        cp -r ${pkgs.fetchFromGitHub {
          owner = "luisbocanegra";
          repo = "plasma-smart-video-wallpaper-reborn";
          rev = "3e136a0c54e6fdb2b5de1354d17ddd474607d2d1";
          hash = "sha256-qXEzT/ZWzvFLbs82DONdgthl7RwqHJMeWW7/HtqJZ+I=";
        }}/package $out/share/plasma/wallpapers/luisbocanegra.smart.video.wallpaper.reborn
        chmod 755 $out/share/plasma/wallpapers/luisbocanegra.smart.video.wallpaper.reborn/contents/ui/tools/gdbus_get_signal.sh
      '')
      pkgs.qt6.qtmultimedia
    ];
  };
}
