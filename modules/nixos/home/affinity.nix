{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  home.packages = with pkgs.affinity-nix; [
    affinity-v3
  ];

}
