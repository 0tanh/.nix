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
    bash-language-server
    dockerfile-language-server
    just-lsp
    lua-language-server
    nixd
    nixfmt
    prettier
    python3Packages.python-lsp-server
    ruff
    rustfmt
    sqlls
    stylua
    terraformls
    vscode-langservers-extracted
    yamlls
  ];
}
