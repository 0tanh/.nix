{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
in
{
  # This config uses the mango window manager and caelestia shell
  imports = [
    ../mango.nix
    ../caelestia.nix
  ];

}
