{ lib, ... }:
{
  imports = lib.helpers.scanPaths ./.;
}
