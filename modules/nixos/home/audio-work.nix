{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # This module imports a bunch of related modules for audio-work,
  # e.g. DAWs, Audio Programming Frameworks, Audio Editors, etc.
  imports = [
    ./reaper.nix
    ./puredata.nix
  ];
  home.packages = with pkgs; [
    bespokesynth
    bitwig-studio
    faust2
  ];
}
