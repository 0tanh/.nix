{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  config.nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "30min";
      options = "--delete-older-than 7d --max-jobs auto --cores 0";
    };
    optimise = {
      automatic = true;
      dates = [ "03:00" ]; # Periodically optimize the store
    };
    settings = {
      # See https://jackson.dev/post/nix-reasonable-defaults/
      auto-optimise-store = true;
      accept-flake-config = true;
      download-buffer-size = 524288000;
      connect-timeout = 60000;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB
      experimental-features = lib.mkDefault "nix-command flakes"; # Enable flakes and new 'nix' command
      # warn-dirty = false;
      # allow-import-from-derivation = true;
      trusted-users = [
        "@wheel"
        "root"
        "betty"
      ];
      builders-use-substitutes = true;
      fallback = true; # Don't hard fail if a binary cache isn't available, since some systems roam
      substituters = [
        "https://cache.nixos.org" # Official global cache
        "https://nix-community.cachix.org" # Community packages
      ];
      extra-substituters = [
        "https://nix-community.cachix.org" # Nix community Cachix server
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      extraOptions = ''
        	access-tokens = github.com=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
      '';
    };
  };
}
