{ ... }:
{
  flake.modules.homeManager.plasma = {
    programs.plasma.kscreenlocker = {
      autoLock = false;
      lockOnResume = false;
      timeout = 0;
    };

    programs.plasma.powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        powerButtonAction = "nothing";
        dimDisplay.enable = false;
        turnOffDisplay.idleTimeout = "never";
      };
    };
  };
}
