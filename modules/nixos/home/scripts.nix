{
  pkgs,
  config,
  lib,
  ...
}:
{
  home.packages = [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #    echo "Hello, ${config.home.username}!"
    # '')

    (pkgs.writeShellScriptBin "confirm-reboot" ''
      read -n1 -r -p "Do you really want to reboot? [y/N] >" response
      response=''${response,,}
      if [[ "$response" =~ ^(yes|y)$ ]]
      then
        reboot
      fi
    '')
  ];
}
