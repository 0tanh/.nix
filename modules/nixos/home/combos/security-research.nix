{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    cutter
    ghidra
  ];
}
