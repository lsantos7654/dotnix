{ config, inputs, ... }:
let
  inherit (config) username stateVersion;
  inherit (config.flake.modules) homeManager;
in
{
  flake.modules.nixos.user = { pkgs, ... }: {
    users.users.${username} = {
      isNormalUser = true;
      description = "Lucas Santos";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };

    security.sudo.wheelNeedsPassword = false;

    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${username} = {
        imports = [
          inputs.dothome.homeModules.default
          homeManager.plasma
          homeManager.tiling
          homeManager.firefox
        ];
        home.username = username;
        home.homeDirectory = "/home/${username}";
        home.stateVersion = stateVersion;
      };
      backupFileExtension = "backup";
      sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];
    };
  };
}
