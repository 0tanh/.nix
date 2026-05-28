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
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

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
