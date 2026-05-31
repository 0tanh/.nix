{ inputs, pkgs, ... }:

{
  # Install the raw Zen Browser package directly to Betty's user profile
  home.packages = [
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
}
