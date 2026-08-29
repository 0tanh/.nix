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
    ../modules/nixos/home/combos/network-and-security.nix
    ../modules/nixos/home/combos/minimal.nix
    # Standard modules composed for this home manager.
    ../modules/nixos/home/devenv.nix
    ../modules/nixos/home/direnv.nix
    ../modules/nixos/home/dotfiles.nix
    ../modules/nixos/home/firefox.nix
    ../modules/nixos/home/fuzzel.nix
    # ../modules/nixos/home/ghostty.nix
    ../modules/nixos/home/git.nix
    ../modules/nixos/home/godot.nix
    # ../modules/nixos/home/impermanence.nix
    ../modules/nixos/home/kitty.nix
    # ../modules/nixos/home/neovim.nix
    ../modules/nixos/home/packages.nix
    ../modules/nixos/home/pet.nix
    ../modules/nixos/home/spicetify.nix
    ../modules/nixos/home/ssh.nix
    ../modules/nixos/home/tmux.nix
    ../modules/nixos/home/vars.nix
    ../modules/nixos/home/xdg.nix
    ../modules/nixos/home/zen-browser.nix
    ../modules/nixos/home/zsh.nix
  ]
  # Desktop Environment
  ++ [
    ../modules/nixos/home/desktop-env/mango-quickshell.nix
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

  # This fixes issues with mango if it is loaded
  wayland.windowManager.mango.extraConfig = ''
    # set up wallpaper
    exec-once=${pkgs.swaybg}/bin/swaybg -i ~/.nix/assets/img/aoi.jpg -m center
    
    # Use legacy Direct Rendering Manager DRM
    env=WLR_DRM_NO_ATOMIC,1
    # Moniter rules for 2 bad moniters
    monitorrule=name:VGA-1,width:1366,height:768,refresh:59.62,x:1024,y:0
    monitorrule=name:HDMI-A-1,width:1024,height:768,refresh:59.92,x:0,y:0
  '';
}
