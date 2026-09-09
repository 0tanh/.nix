{
  ...
}:
{
  programs.nixvim = {
    #TODO this is in the docs but isnt available with the current patch.
    /**
      lsp = {
        enable = true;
         codelens.enable = true;     };
    */
    plugins = {
      lsp = {
        enable = true;

        # Globally enable keymaps (e.g., jump to definition, hover, rename)
        keymaps = {
          silent = true;
          lspBuf = {
            gd = "definition";
            gD = "references";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        # 1. Toggle multiple language servers to true
        servers = {
          bashls.enable = true; # Bash
          clangd.enable = true; # C/C++
          cssls.enable = true; # CSS
          html.enable = true; # HTML
          jdtls.enable = true; # Java
          jsonls.enable = true; # JSON
          lua-ls.enable = true; # Lua
          pyright.enable = true; # Python
          nil_ls.enable = true; # Nix (NixOS configuration)
          tsserver.enable = true; # TypeScript/JavaScript
          svelte.enable = true; # Svelte
          rust_analyzer.enable = true; # Rust
        };

      };

    };
  };
}
