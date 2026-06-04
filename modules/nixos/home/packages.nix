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

    # Reaper for audio stuff
    reaper
    reaper-reapack-extension
    reaper-sws-extension
    yabridge

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
