{ ... }:

{
  imports = [
    ./theme.nix
    ./kwin.nix
    ./power.nix
    ./wallpaper.nix
    ./tiling.nix
    ./shortcuts.nix
    ./panels.nix
    ./window-rules.nix
    ./gaming.nix
  ];

  programs.plasma.enable = true;
  programs.plasma.overrideConfig = true;
  programs.plasma.session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
}
