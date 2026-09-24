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
    ../blender.nix
    ../figma.nix
    ../kodelife.nix
    ../lutris.nix
    ../obs.nix
  ];

  home.packages =
    with pkgs;
    [
      # Image editing
      affinity-v3
      # fun drawing with other people :3
      drawpile
      # Video Editing
      kdePackages.kdenlive
      # Drawing
      krita
      # Reference pinboard
      pureref
    ]

    ++ (with pkgs.stable; [
      inkscape
    ]);
}
