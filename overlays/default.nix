{ inputs, ... }:
{
  # Include custom pkgs in ./pkgs in nixpkgs.
  # Allows calling them normally like pkgs.customPkg
  additions =
    final: prev:
    import ../pkgs {
      pkgs = final;
      inherit inputs;
    };

  # Inject stable as an attr of nixpkgs from the nixpkgs-stable input
  # Allow version pinning pkgs to an older version when needed (breakages, etc)
  # To use, when referencing a pkg: pkgs.stable.pkgName
  stable-packages = final: prev: {
    stable = import inputs.nixpkgs-stable { system = final.system; };
  };
}
