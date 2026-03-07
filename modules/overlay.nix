{ ... }:
{
  flake.modules.nixos.overlay = {
    nixpkgs.overlays = [
      (final: prev: {
        kde-rounded-corners = prev.kde-rounded-corners.overrideAttrs (old: {
          version = "0.8.6-unstable-2025-12-19";
          src = prev.fetchFromGitHub {
            owner = "matinlotfali";
            repo = "KDE-Rounded-Corners";
            rev = "876a88188c819b080db8fc3d0f36ecff8fdbec42";
            hash = "sha256-gwsGQxBvZzgsSsMoN5rgDyyjxL/fNAtYwLgfxcKj5lk=";
          };
        });
      })
    ];
  };
}
