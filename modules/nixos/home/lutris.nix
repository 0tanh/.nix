{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # Extra wine configuration to get Lutris working
  home.packages = with pkgs; [
    lutris
    umu-launcher
    winetricks
  ];
}
