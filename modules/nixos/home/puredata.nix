{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # Pure data is a node based audio-visual programming language
  # This modules contains it and it's utils.
  home.packages = with pkgs; [
    # The puredata runtime itself
    puredata
    # Helpful puredata utilities
    # More utils can be found at https://git.iem.at/pd
    # MaxMSP compatibility
    cyclone
    # Non-"tilde" (AV) utils for puredata
    maxlib
    # Audio analysis features for puredata
    timbreid
    # Misc utils
    zexy
  ];
}
