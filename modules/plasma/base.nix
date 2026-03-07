{ ... }:
{
  flake.modules.homeManager.plasma = {
    programs.plasma.enable = true;
    programs.plasma.overrideConfig = true;
    programs.plasma.session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
  };
}
