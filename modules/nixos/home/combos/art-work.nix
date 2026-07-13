{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # This module imports a bunch of related modules for working with and making visual art
  # e.g. Image Editors, 3D graphics, Vector Graphics
  imports = [
    ../figma.nix
    ../blender.nix
  ];

  home.packages =
    with pkgs;
    [
      affinity-v3
      krita
    ]

    ++ (with pkgs.stable; [
      inkscape
    ]);
}
