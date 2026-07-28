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
    ../reaper.nix
    ../puredata.nix
  ];
  home.packages = with pkgs; [
    # Modular Synth like environment
    bespokesynth
    # Moudlar paid DAW
    bitwig-studio
    # Pure functional DSP programming language
    faust2
    # Audio rerouting
    pipewire.jack
    qpwgraph
    # install vst3 and clap plugins on Linux
    yabridgectl
  ];
}
