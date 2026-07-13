{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # This module includes all dependencies for working with Figma
  home.packages = with pkgs; [
    figma-linux
    figma-agent
  ];
}
