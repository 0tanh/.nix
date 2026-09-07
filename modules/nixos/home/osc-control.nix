{
  inputs,
  pkgs,
  config,
  ...
}:
{
  # SOURCE: https://github.com/0tanh/osc-utility
  # Enables the osc-control command line utility
  home.packages = [
    inputs.osc-control.packages.${pkgs.system}.default
  ];
}
