{ lib, ... }:
{
  options = {
    username = lib.mkOption {
      type = lib.types.singleLineStr;
      readOnly = true;
      default = "santos";
    };

    stateVersion = lib.mkOption {
      type = lib.types.singleLineStr;
      readOnly = true;
      default = "25.11";
    };
  };
}
