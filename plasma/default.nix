{ pkgs, ... }:

let
  kwin-geometry-change = pkgs.fetchFromGitHub {
    owner = "peterfajdiga";
    repo = "kwin4_effect_geometry_change";
    rev = "v1.5";
    hash = "sha256-p4FpqagR8Dxi+r9A8W5rGM5ybaBXP0gRKAuzigZ1lyA=";
  };
in
{
  imports = [
    ./theme.nix
    ./shortcuts.nix
    ./panels.nix
    ./window-rules.nix
  ];

  # Install Geometry Change KWin effect
  xdg.dataFile."kwin/effects/kwin4_effect_geometry_change" = {
    source = "${kwin-geometry-change}/package";
    recursive = true;
  };

  programs.plasma.enable = true;
  programs.plasma.overrideConfig = true;
}
