{
  description = "Hundredrabbits tools packaged with Deno";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        # This imports the file containing the Deno derivations
        import ./default.nix {
          inherit (pkgs)
            lib
            newScope
            system
            stdenv
            pkgs
            callPackage
            ;
        }
      );
    };
}
