{ inputs, pkgs, ... }:
let
  ableton-in = inputs.ableton-linux.packages.${pkgs.system};
in
{
  # Install all associated apps from the ableton-linux project
  # https://github.com/shibco/ableton-linux/blob/main/flake.nix
  home.packages = with ableton-in; [
    default
  ];
}
