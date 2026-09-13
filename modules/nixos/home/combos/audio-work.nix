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
    ../ableton.nix
    ../osc-control.nix
    ../protokol.nix
    ../puredata.nix
    ../reaper.nix
  ];
  home.packages = with pkgs; [
    # Modular Synth like environment
    bespokesynth
    # Moudlar paid DAW
    bitwig-studio
    # Modular patch environment
    cardinal
    # Pure functional DSP programming language
    mixxx
    faust2
    # Audio rerouting
    pipewire.jack
    qpwgraph

    vital
    #vital-vst
    # wineWowPackages.stable
    # install vst3 and clap plugins on Linux
    yabridgectl
  ];
}
