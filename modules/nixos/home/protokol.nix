{
  inputs,
  pkgs,
  config,
  ...
}:
{
  # Enables the Protokol Midi and OSC message viewer
  home.packages = [
    inputs.protokol.packages.${pkgs.system}.default
  ];
}
