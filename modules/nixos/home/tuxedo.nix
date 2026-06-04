{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.tuxedo;
in
{
  # 1. Define the option interface to match your paradigm
  options.programs.tuxedo = {
    enable = lib.mkEnableOption "Tuxedo todo.txt terminal UI";
  };

  # 2. Tell Home Manager what to do if the option is set to true
  config = lib.mkIf cfg.enable {
    home.packages = [
      # Pulls the package from the inline overlay we set up in flake.nix
      pkgs.tuxedo
    ];
  };
}
