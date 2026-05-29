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
    bashls
    dockerls
    jsonls
    lua_ls
    nixfmt
    prettier
    pylsp
    ruff
    rustfmt
    sqlls
    stylua
    terraformls
    yamlls
  ];
}
