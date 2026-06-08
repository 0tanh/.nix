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

      python314
      mpv
      telegram-desktop
      swaybg
      vlc
      zeal

      # Reaper for audio stuff
      reaper
      reaper-reapack-extension
      reaper-sws-extension
      yabridge

      # nvim language servers & formatters
      bash-language-server
      docker-compose-language-service
      dockerfile-language-server
      jdt-language-server
      just-lsp
      lua-language-server
      nixd
      nixfmt
      prettier
      python3Packages.python-lsp-server
      ruff
      rustfmt
      stylua
      svelte-language-server
      terraform-ls
      vscode-langservers-extracted
      yaml-language-server
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
