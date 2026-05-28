{ lib, pkgs, ... }:
{
  # Imported by flake.nix using recursiveUpdate into nixpkgs.lib
  # Makes these functions available elswhere via lib.helpers.func
  helpers = {
    # Get whether this system is a linux or darwin (macOS) system
    isDarwin = pkgs.stdenv.isDarwin;
    isLinux = pkgs.stdenv.isLinux;

    # Use path relative to the root of the flake
    # Usage: relativeToRoot "modules/nixos/directoryOrFileDotNix"
    relativeToRoot = lib.path.append ../.;
  };
}
