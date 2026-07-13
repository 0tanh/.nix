{
  pkgs,
  lib,
  config,
  ...
}:
{
  # packages specifically designed for more minimal installs
  home.packages = with pkgs; [
    browsh
    dillo
    mosh
    ghostty
  ];
}
