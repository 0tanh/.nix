{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = with pkgs; [

    # Custom wrapped Neovim with Treesitter Grammars baked in
    (neovim.override {
      configure = {
        packages.myVimPackage = {
          start = with pkgs.vimPlugins; [
            (nvim-treesitter.withPlugins (
              p: with p; [
                tree-sitter-typescript
                tree-sitter-javascript
                tree-sitter-lua
                tree-sitter-nix
                tree-sitter-html
                tree-sitter-css
                tree-sitter-json
                tree-sitter-java
                tree-sitter-c
                tree-sitter-elixir
                tree-sitter-heex
                tree-sitter-svelte
              ]
            ))
          ];
        };
      };
    })

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
