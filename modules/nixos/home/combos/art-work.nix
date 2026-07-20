{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # This module imports a bunch of related modules for working with and making visual art
  # e.g. Image Editors, 3D graphics, Vector Graphics, as well as video recording utilities

  imports = [
    ../figma.nix
    ../blender.nix
    ../obs.nix
  ];

  home.packages =
    with pkgs;
    [
      # Image editing
      affinity-v3
      # Video Editing
      kdePackages.kdenlive
      # Drawing
      krita
    ]

    ++ (with pkgs.stable; [
      inkscape
    ]);
}
