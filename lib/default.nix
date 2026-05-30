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

    # Scan all paths in the given directory, returning a list of directories and *.nix files,
    # not including 'default.nix'. Useful within a directory's 'default.nix' with
    # `imports = scanPaths ./.;` as a way to automatically pull in all other files in a directory.
    scanPaths =
      path:
      builtins.map (f: (path + "/${f}")) (
        builtins.attrNames (
          lib.attrsets.filterAttrs (
            path: _type:
            (_type == "directory") # include directories
            || (
              (path != "default.nix") # ignore default.nix
              && (lib.strings.hasSuffix ".nix" path) # include .nix files
            )
          ) (builtins.readDir path)
        )
      );
  };
}
