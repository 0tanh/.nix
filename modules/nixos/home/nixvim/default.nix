{
  inputs,
  pkgs,
  ...
}:
{

  # SOURCE: https://nix-community.github.io/nixvim/index.html
  imports = [
    # This is the critical line missing from Betty's Home Manager scope
    inputs.nixvim.homeModules.nixvim
    ./cmp.nix
    ./conform.nix
    ./glsl.nix
    ./keymap.nix
    ./lsp.nix
    ./mini.nix
    ./neotree.nix
    ./opts.nix
    ./snippets.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    nixpkgs.useGlobalPackages = true;
    enable = true;
    colorschemes.catppuccin.enable = true;

    defaultEditor = true;
    extraPlugins = [ ];

    opts = {
      number = true;
      relativenumber = false;
      termguicolors = true;
    };
    plugins = {

      comment.enable = true; # comment
      indent-blankline.enable = true; # indent-blankline
      friendly-snippets.enable = true; # (Optional) Load pre-written snippets for most languages
      gitsigns.enable = true; # gitsigns
      highlight-colors = {
        enable = true;
        cmpIntegration = false;
      };
      lazygit.enable = true;
      lualine.enable = true;
      luasnip.enable = true;
      none-ls.enable = true; # none-ls
      mini-icons.enable = true;
      web-devicons.enable = true;
      render-markdown.enable = true; # render-markdown
      telescope.enable = true;
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
}
