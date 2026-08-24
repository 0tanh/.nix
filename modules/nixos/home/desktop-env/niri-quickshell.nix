{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ../niri.nix
    ../quickshell.nix
  ];
}
