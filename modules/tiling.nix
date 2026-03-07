{ ... }:
{
  flake.modules.nixos.tiling = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.kdePackages.krohnkite ];
  };
}
