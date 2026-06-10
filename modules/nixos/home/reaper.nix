{
  pkgs,
  lib,
  config,
  ...
}:
{

  home.packages = with pkgs; [
    # Reaper for audio stuff
    reaper
    reaper-reapack-extension
    reaper-sws-extension
    yabridge
  ];
}
