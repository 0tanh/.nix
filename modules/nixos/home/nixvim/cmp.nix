{
  ...
}:
{
  programs.nixvim = {
    plugins = {
      # 1. The Core Engine
      cmp = {
        enable = true;
        autoEnableSources = true;

        settings = {
          # Required snippet expansion logic
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          # The sources to pull completions from, in order of priority
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];

          # Standard IDE keymaps
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = false })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-u>" = "cmp.mapping.scroll_docs(-4)";
            "<C-d>" = "cmp.mapping.scroll_docs(4)";
          };

          # Adds rounded borders to the completion windows
          window = {
            completion = {
              border = "rounded";
            };
            documentation = {
              border = "rounded";
            };
          };
        };
      };

      # 2. Command-line completion (for `:` commands and `/` searches)
      cmp-cmdline.enable = true;

      # 3. Snippet Engine (Strictly required for cmp to work with LSPs)
      luasnip.enable = true;

      # 4. Pre-written snippets for most programming languages
      friendly-snippets.enable = true;

      # 5. Adds VSCode-like pictograms and source tags to the completion menu
      lspkind = {
        enable = true;
        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            luasnip = "[Snip]";
            buffer = "[Buf]";
            path = "[Path]";
          };
        };
      };
    };
  };
}
