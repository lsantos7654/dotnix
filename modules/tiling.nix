{ pkgs, ... }:

{
  # Krohnkite tiling extension
  environment.systemPackages = [ pkgs.kdePackages.krohnkite ];

  # Plasma tiling config (krohnkite settings + shortcuts)
  home-manager.users.santos.imports = [ ../plasma/tiling.nix ];
}
