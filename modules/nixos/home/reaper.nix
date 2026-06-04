{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.reaper = {
    enable = true;
  };

  programs.reaper-reapack-extension = {
    enable = true;
  };

  programs.reaper-sws-extension = {
    enable = true;
  };

  programs.yabridge = {
    enable = true;
  };

}
