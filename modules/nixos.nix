{ lib, config, ... }:
{
  options.configurations.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.system = lib.mkOption {
          type = lib.types.str;
        };

        options.module = lib.mkOption {
          type = lib.types.deferredModule;
        };
      }
    );
  };

  config.flake.nixosConfigurations = lib.mapAttrs
    (name: { system, module }:
      lib.nixosSystem {
        inherit system;
        modules = [ module ];
      })
    config.configurations.nixos;

  config.flake.checks = lib.mkMerge (
    lib.mapAttrsToList (
      name: nixos: {
        ${nixos.config.nixpkgs.hostPlatform.system} = {
          "configurations:nixos:${name}" = nixos.config.system.build.toplevel;
        };
      }
    )
    config.flake.nixosConfigurations
  );
}
