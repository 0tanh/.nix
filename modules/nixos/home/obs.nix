{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # This module imports all the necessary functionality for working with obs studio

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
  };
}
