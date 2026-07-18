{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  all-configs = {
    modules = ../../../assets/submodule/dotfiles/quickshell/modules;
    overview = ../../../assets/submodule/dotfiles/quickshell/overview;
    services = ../../../assets/submodule/dotfiles/quickshell/services;
    main = ../../../assets/submodule/dotfiles/quickshell/main;
  };
  qs-path = {

  };
in
{
  # Configuration for writing a quickshell rice on nix
  # Link to ~/.config/quickshell/ from dotfiles/quickshell
  xdg.configFile."quickshell".source = ../../../assets/submodule/dotfiles/quickshell;
  # QuickShell for things like sidebar.
  programs.quickshell = {
    enable = true;
    systemd = {
      enable = true; # if you prefer starting from your compositor
      target = "graphical-session.target";
    };
  };
}
