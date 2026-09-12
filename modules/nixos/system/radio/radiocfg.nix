{
  lib,
  config,
  inputs, # TODO pass in a realpassword
  ...
}:
let
  port = 8085;
in
{
  options.radioCfg = {
    port = lib.mkOption {
      type = lib.types.ints.u16;
      default = port;
    };
    # Password for actual steaming server
    sourcePassword = lib.mkOption {
      type = lib.types.str;
      default = "hackme";
    };

    # Password for actual steaming server
    adminPassword = lib.mkOption {
      type = lib.types.str;
      default = "admin";
    };
  };
}
