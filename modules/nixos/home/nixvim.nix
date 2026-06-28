{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;

    extraPlugins = [ ];

    plugins = {

      lualine.enable = true;

      treesitter = {

        enable = true;

        # Explicitly supply grammar packages
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          svelte
          html
          css
          javascript
          typescript

        ];
      };

      # Enable the core LSP module
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
          jsonls.enable = true; # JSON
          lua-ls.enable = true; # Lua
          pyright.enable = true; # Python
          nil_ls.enable = true; # Nix (NixOS configuration)
          tsserver.enable = true; # TypeScript/JavaScript
          svelte.enable = true;
        };
      };
      extraConfigLua = ''
        -- Auto-format on save
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("LspFormatting", {}),
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.supports_method("textDocument/formatting") then
              vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
              end, { buffer = args.buf, desc = "Format current buffer" })
              
              -- Format on save
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                  vim.lsp.buf.format({ async = false, id = client.id })
                end,
              })
            end
          end,
        })
      '';
    };
  };
}
