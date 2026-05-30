{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      # See https://sw.kovidgoyal.net/kitty/conf.html
      confirm_os_window_close 0
      cursor_trail 5
      cursor_trail_decay 0.05 0.25
      cursor_trail_start_threshold 5
      background_opacity 0.6
      allow_remote_control socket-only
      listen_on unix:/tmp/kitty
    '';
  };
}
