{
  ...
}:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;

      settings = {
        # Trigger formatting automatically on save
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
        };

        # (Optional) Map specific formatters to filetypes.
        # If a filetype isn't listed here, Conform will just use your LSP (like clangd or tsserver).
        formatters_by_ft = {
          nix = [ "nixfmt" ];
          javascript = [ "prettier" ];
          typescript = [ "prettier" ];
          svelte = [ "prettier" ];
          css = [ "prettier" ];
          html = [ "prettier" ];
          lua = [ "stylua" ];
        };
      };
    };
  };
}
