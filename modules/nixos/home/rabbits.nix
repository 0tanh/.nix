{
  pkgs,
  lib,
  helpers,
  config,
  user,
  inputs,
  ...
}:
let
  cfg = config;
  usr = config.opts.usr.${user};
  mod = usr.mod.hundredrabbits;

  # https://github.com/egasimus/rabbits
  rabbits = inputs.rabbits.packages.${pkgs.system};
in
{
  home.packages = [
    rabbits.pilot
    rabbits.marabu
    rabbits.left
    rabbits.ronin
    rabbits.dotgrid

  ];
}
