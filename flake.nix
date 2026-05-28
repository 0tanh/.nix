{
  inputs = {
    ## PACKAGE CHANNELS ##
    # Primary nixpkgs repository: use unstable (latest rolling) by default
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Pinned nixpkgs to most recent stable, will be injected via an overlay
    # You may want to edit this pin to new stables periodically
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    ## PUBLIC INPUTS ##
    # Declarative partitioning and formatting
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Manage your user's $HOME in addition to the system
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Persist & link data into your ephemeral root at boot time
    impermanence = {
      url = "github:nix-community/impermanence";
    };

    # Community-managed modular hardware configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # Community sourced, pre-configured git pre-commit hooks
    # Runs useful tools on pre-commit to lint & check for errors before creating a commit
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SOPS-based secrets management
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    ## PRIVATE INPUTS

  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      home-manager,
      impermanence,
      nixos-hardware,
      sops-nix,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      # Useful helper to provide a list of system architectures you want an attrSet to be eval'able for
      # Wraps around genAttrs: https://noogle.dev/f/lib/genAttrs/
      # Provides systems as inputs to other functions
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        # "x86_64-darwin"
        # "aarch64-darwin"
      ];

      # Returns the nixpkgs input while adding all overlays in ./overlays (checks for default.nix when specifying a directory)
      # Func that receives system architecture(s)
      # In particular, injects the stable package channel as an attr (nixpkgs.stable.pkg)
      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          overlays = (import ./overlays { inherit inputs; });
        };

      # Returns nixpkgs.lib including our own lib functions found in ./lib (default.nix)
      # Func that receives system architecture(s)
      # Wraps around recursiveUpdate: https://noogle.dev/f/lib/recursiveUpdate/
      lib =
        system:
        nixpkgs.lib.recursiveUpdate (import ./lib {
          pkgs = mkPkgs system;
          lib = nixpkgs.lib;
        }) nixpkgs.lib;
    in
    {
      # Provides flake-wide tests to run on evaluation and in devshell
      # Usage: nix flake check
      checks = forAllSystems (system: {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixfmt-rfc-style.enable = true;
          };
        };
      });

      # Flake formatter. RFC style is modern, maintained and clean
      formatter = forAllSystems (
        system:
        let
          pkgs = mkPkgs system;
        in
        pkgs.nixfmt-rfc-style
      );

      # replace yourHostname with your actual hostname!
      nixosConfigurations.lily = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./disko.nix
          disko.nixosModules.disko
          nixos-hardware.nixosModules.apple-macbook-air-7
        ];
      };
    };
}
