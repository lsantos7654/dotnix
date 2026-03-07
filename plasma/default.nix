{ ... }:

{
  imports = [
    ./theme.nix
    ./kwin.nix
    ./tiling.nix
    ./power.nix
    ./wallpaper.nix
    ./shortcuts.nix
    ./panels.nix
    ./window-rules.nix
  ];

  programs.plasma.enable = true;
  programs.plasma.overrideConfig = true;
  programs.plasma.session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
}
