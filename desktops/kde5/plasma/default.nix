{ ... }:

{
  imports = [
    ./theme.nix
    ./shortcuts.nix
    ./panels.nix
    ./window-rules.nix
  ];

  programs.plasma.enable = true;
  programs.plasma.overrideConfig = true;
}
