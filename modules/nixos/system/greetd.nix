{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
in
{
  config = {
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "mango";
          user = "betty";
        };
        default_session = {
          command = "${tuigreet} --time --remember --cmd 'mango'";
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
