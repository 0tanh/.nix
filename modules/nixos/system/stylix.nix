{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    # this fixes a bug in a new version of nix flakes
    targets.kmscon.enable = false;
    # https://nix-community.github.io/stylix/configuration.html
    # Automatically set wallpaper, and generate a system colorscheme pallete using the folloing image.
    image = ../../../assets/img/aesthetic_bg.png;
    # View the palette at /etc/stylix/palette.html
    polarity = "dark";
  };
}
