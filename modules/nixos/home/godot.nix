{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # Requirements to work with godot on nix
  home.packages = with pkgs; [
    godot
  ];
}
