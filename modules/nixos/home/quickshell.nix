{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  quickshell-source = "${inputs.dotfiles}/quickshell";
in
{
  # Configuration for writing a quickshell rice on nix
  # Link to ~/.config/quickshell/ from dotfiles/quickshell
  # NOTE: this would be one way to do this, but statically linked dotfiles are a pain in the ass.
  # instead, i recommend symlinking with a post-build script as seen in modules/nixos/home/dotfiles
  # xdg.configFile."quickshell".source = quickshell-source;

  # QuickShell for things like sidebar.
  programs.quickshell = {
    enable = true;
    systemd = {
      enable = true; # if you prefer starting from your compositor
      target = "graphical-session.target";
    };
  };
}
