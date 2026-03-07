{ pkgs, ... }:

{
  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  hardware.steam-hardware.enable = true;

  # Gaming packages
  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    steamtinkerlaunch
  ];

  # Plasma gaming config (gaming-mode-toggle, gamescope window rule)
  home-manager.users.santos.imports = [ ../plasma/gaming.nix ];
}
