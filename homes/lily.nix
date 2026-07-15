{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Combos are groups of related modules for easy set-up on a new machine, depending on need
    ../modules/nixos/home/combos/art-work.nix
    ../modules/nixos/home/combos/audio-work.nix
    ../modules/nixos/home/combos/dev-work.nix
    ../modules/nixos/home/combos/minimal.nix
    # Standard modules composed for this home manager.
    ../modules/nixos/home/devenv.nix
    ../modules/nixos/home/direnv.nix
    ../modules/nixos/home/dotfiles.nix
    ../modules/nixos/home/firefox.nix
    ../modules/nixos/home/fuzzel.nix
    ../modules/nixos/home/ghostty.nix
    ../modules/nixos/home/git.nix
    ../modules/nixos/home/godot.nix
    ../modules/nixos/home/impermanence.nix
    ../modules/nixos/home/kitty.nix
    ../modules/nixos/home/mango-quickshell.nix
    ../modules/nixos/home/neovim.nix
    ../modules/nixos/home/packages.nix
    ../modules/nixos/home/pet.nix
    ../modules/nixos/home/spicetify.nix
    ../modules/nixos/home/ssh.nix
    ../modules/nixos/home/tmux.nix
    ../modules/nixos/home/vars.nix
    ../modules/nixos/home/xdg.nix
    ../modules/nixos/home/zen-browser.nix
    ../modules/nixos/home/zsh.nix
  ];

  # Prevents inkscape from being recompiled from source when stylix config changes
  disabledModules = [
    "${inputs.stylix}/modules/inkscape/home-manager.nix"
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "betty";
  home.homeDirectory = "/home/betty";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Sets the default applications for different MIME types
  #
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
    };
  };
}
