{
  pkgs,
  lib,
  config,
  ...
}:
{

  home.packages = with pkgs; [
    # nvim language servers & formatters
    bash-language-server
    docker-compose-language-service
    dockerfile-language-server
    jdt-language-server
    just-lsp
    lua-language-server
    nixd
    nixfmt
    prettier
    python3Packages.python-lsp-server
    ruff
    rustfmt
    stylua
    svelte-language-server
    terraform-ls
    vscode-langservers-extracted
    yaml-language-server
  ];
}
