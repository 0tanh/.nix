{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # Packages added here have not been added as dedicated nix modules
  # and cannot be enabled with a simple packages.foo.enable = true
  # flag. The use must manage the dotfiles for these seperately.
  #
  # as of 06/06/2026 the recommnended workflow is to use the
  # ../../../assets/submodule/dotfiles/ directory to manage these files
  home.packages =
    with pkgs;
    [
      #TODO refactor this into its own package
      affinity-v3

      python314
      mpv
      telegram-desktop
      swaybg
      vlc
      zeal

    ]

    # these packages are from a stable version of
    # nixpkgs. Inkscape is here to reduce its build time.
    ++ (with pkgs.stable; [
      inkscape
      vesktop
    ])

    # these packages are being pulled from the latest version of
    # nixpkgs. They might be less stable.
    ++ (with pkgs.bleeding; [
      tuxedo
    ])

  ;

}
