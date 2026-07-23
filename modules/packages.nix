{ ... }:
{
  flake.modules.nixos.packages = { lib, pkgs, ... }:
  {
    programs.zsh.enable = true;

    # Force Chromium to preserve session cookies (sp_dc/sp_key) across
    # restarts so the Spotify web player stays logged in.
    environment.etc."chromium/policies/managed/spotify-session.json".text =
      builtins.toJSON { RestoreOnStartup = 1; };

    fonts.packages = with pkgs; [
      nerd-fonts.hack
    ];

    environment.systemPackages = with pkgs; [
      # Core tools
      vim
      git
      gh
      clang
      curl
      wget
      htop
      btop
      alsa-utils
      git-lfs

    ]
    ++ [
      (pkgs.chromium.override { enableWideVine = true; commandLineArgs = "--password-store=basic"; })
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
      # KDE Plasma extras
      papirus-icon-theme
      plasmusic-toolbar

      # Gaming
      mangohud
      protonup-qt
      steamtinkerlaunch
      discord

      # Apps
      spotify
    ];
  };
}
