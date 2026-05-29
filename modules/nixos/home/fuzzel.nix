{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.fuzzel = {
    enable = true;
  };
}
