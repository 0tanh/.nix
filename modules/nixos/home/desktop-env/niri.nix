{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # This configuration uses the niri window manager
  programs.niri = {
    enable = true;
  };
}
