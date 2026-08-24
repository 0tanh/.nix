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
      goofcord
      #TODO move nicotine, mpv, vlc, and ncspot to the same combo
      # Soulseek Client
      nicotine-plus
      # Space monitering
      ncdu
      # sending stuff
      magic-wormhole
      # Media Player
      mpv
      p7zip
      python314
      qbittorrent
      telegram-desktop
      rclone
      swaybg
      vlc
      unrar
      unzip
      webcamoid
      yt-dlp
    ]

    # these packages are from a stable version of
    # nixpkgs. Inkscape is here to reduce its build time.
    ++ (with pkgs.stable; [
      vesktop
    ])

    # these packages are being pulled from the latest version of
    # nixpkgs. They might be less stable.
    ++ (with pkgs.bleeding; [
      tuxedo
    ])

  ;

}
