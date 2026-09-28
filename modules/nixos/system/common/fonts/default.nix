{ lib, pkgs, ... }:
let
  berkeley = ../../../../../pkgs/berkeley/default.nix;
  font454 = ../../../../../pkgs/454font/default.nix;
in
{

  imports = (
    lib.helpers.scanPaths ./.

  );

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    # ((pkgs.callPackage (berkeley) { })
    (pkgs.callPackage (font454) { })
  ];
}
