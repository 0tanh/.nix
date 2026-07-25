{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # This configuration combines the mango window manager with my custom quickshell rice

  imports = [
    ../mango.nix
    ../quickshell.nix
  ];
}
