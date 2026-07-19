{ ... }:
{
  flake.modules.homeManager.plasma = {
    programs.plasma.enable = true;
    programs.plasma.overrideConfig = true;
    programs.plasma.session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    programs.plasma.input.keyboard.layouts = [{ layout = "us"; }];
    programs.plasma.input.keyboard.options = [ "ctrl:nocaps" "altwin:swap_alt_win" ];
    programs.plasma.configFile.kwalletrc.Wallet.Enabled = false;
  };
}
