{
  helpers,
  inputs,
  pkgs,
  ...
}:
let
  base24 = pkgs.callPackage (../../../pkgs/base24/default.nix) { };
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    # this fixes a bug in a new version of nix flakes
    targets.kmscon.enable = false;

    targets.nixvim.enable = false; # TODO Find a working colour scheme

    # https://nix-community.github.io/stylix/configuration.html
    # Automatically set wallpaper, and generate a system colorscheme pallete using the folloing image.
    image = ../../../assets/img/SPLINTER_Wallpaper_Cut.png;
    # View the palette at /etc/stylix/palette.html

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-savanna.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/embers.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/vulcan.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/valua.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/greenscreen.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/icy.yaml";
    # base16Scheme = "${base24}/share/themes/alien-blood.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/stelia.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/summercamp.yaml";
    # base16Scheme = "${base24}/share/themes/crayon-pony-fish.yaml";
    # base16Scheme = "${base24}/share/themes/fun-forrest.yaml";
    # base16Scheme = "${base24}/share/themes/shaman.yaml";
    # base16Scheme = "${base24}/share/themes/wryan.yaml";
    # base16Scheme = "${base24}/share/themes/sea-shells.yaml";
    base16Scheme = "${base24}/share/themes/spacedust.yaml";

    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };
  };
}
