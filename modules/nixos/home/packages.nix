{

  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    inkscape
    python314
    telegram-desktop
    zeal

    # nvim language servers & formatters
    bash-language-server
    docker-compose-language-service
    dockerfile-language-server
    just-lsp
    lua-language-server
    nixd
    nixfmt
    prettier
    python3Packages.python-lsp-server
    ruff
    rustfmt
    stylua
    terraform-ls
    vscode-langservers-extracted
    yaml-language-server
  ];
}
