{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  desktopEnv = "mango";
in
{
  config = {
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = desktopEnv;
          user = "betty";
        };
        default_session = {
          command = "${tuigreet} --time --remember --cmd '${desktopEnv}'";
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
