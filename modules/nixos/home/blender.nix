{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # Requirements to work with blender on nix
  home.packages = with pkgs; [
    blender
  ];
}
