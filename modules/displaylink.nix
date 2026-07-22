{ ... }:
{
  flake.modules.nixos.displaylink = { ... }: {
    # Dell D6000 dock — enables the upstream NixOS DisplayLink module:
    # evdi kernel module, DisplayLinkManager (dlm.service), udev rules,
    # suspend/resume hooks. (X11 OutputClass bits are inert on Wayland.)
    services.xserver.videoDrivers = [ "displaylink" ];
  };
}
