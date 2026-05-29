{

  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    python314

    # nvim language servers & formatters
    ruff
    rustfmt
    stylua
    nixfmt
    prettier
  ];
}
