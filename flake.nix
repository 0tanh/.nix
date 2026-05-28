{
  inputs = {
    ## PACKAGE CHANNELS ##
    # Don't forget to periodically update the lockfile: nix flake update
    # Only do this when you're ready to fix any breaking changes, however

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

      # Variable to hold all overlays in ./overlays
      # By default, nix will check for default.nix within when provided a directory as a path
      overlays = import ./overlays { inherit inputs; };

      # Returns the nixpkgs input while adding all overlays
      # Func that receives system architecture(s)
      # In particular, injects the stable package channel as an attr (nixpkgs.stable.pkg)
      mkPkgs =
        system:
        import nixpkgs {
          inherit system overlays;
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

      mkSystem =
        system:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            lib = lib system;
          };
        };

    in
    {
      # Shorthand for overlays (the output) = overlays (the 'let' variable) ;
      inherit overlays;

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

      # Activate a temporary shell environment with extra packages and settings
      # Can be auto-activated using nix-direnv, or loaded from the flake remotely using nix+git
      # Usage (anywhere within the flake): nix develop
      devShells = forAllSystems (
        system:
        let
          pkgs = mkPkgs system;
        in
        {
          default = pkgs.mkShell {
            # Inherit the flake's own checks shellHook to load on shell activation
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            # Environment variables
            NIX_CONFIG = "experimental-features = nix-command flakes";
            # Include packages to be available in the shell env
            packages = [
              curl
              git
              magic-wormhole
              neovim
            ];
          };
        }
      );

      # Flake formatter. RFC style is modern, maintained and clean
      formatter = forAllSystems (
        system:
        let
          pkgs = mkPkgs system;
        in
        pkgs.nixfmt-rfc-style
      );

      nixosConfigurations = {
        # Provides the NixOS system configuration as an output of the flake.
        # Evaluated by nixos-rebuild when generating a new system configuration.
        # mkSystem provides a base system to share between machines,
        # updated with a set of modules specific for each machine.
        #
        # See update syntax: https://nix.dev/manual/nix/2.34/language/operators#update
        #
        # forAllSystems : (listOf str) systems
        #  ... mkSystem : (str) system -> (attrSet) nixosSystem
        #  ... update   : (attrSet) baseSystem + (attrSet) additionalAttrs
        lily = forAllSystems (
          system:
          mkSystem system
          // {
            modules = [
              ./configuration.nix
              ./disko.nix
              disko.nixosModules.disko
              nixos-hardware.nixosModules.apple-macbook-air-7
            ];
          }
        );
      };
    };

}
