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

    # https://nix-community.github.io/stylix/configuration.html
    # Automatically set wallpaper, and generate a system colorscheme pallete using the folloing image.
    image = ../../../assets/img/purple-lake.png;
    # View the palette at /etc/stylix/palette.html
    polarity = "dark";
  };
}
