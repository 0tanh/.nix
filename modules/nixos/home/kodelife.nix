{
  inputs,
  pkgs,
  config,
  ...
}:
{
  # Enables the KodeLife shader editor
  home.packages = [
    inputs.kodelife.packages.${pkgs.system}.default
  ];
}
