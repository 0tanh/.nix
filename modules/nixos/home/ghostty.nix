{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.ghostty = {
    enable = true;
  };
}
