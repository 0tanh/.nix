{
  inputs,
  pkgs,
  config,
  lib,
  host,
  helpers,
  host,
  ...
}:
let
  opts = config.opts;
  vars = config.opts.vars.${host};
  isIncluded = lib.lists.elem "greetd" vars.modules;
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
in
{
  config = lib.mkIf isIncluded {
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = vars.greeterCommand;
          user = vars.mainUser;
        };
        default_session = {
          command = "${tuigreet} --time --remember --cmd '${vars.greeterCommand}'";
          user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "tty";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
