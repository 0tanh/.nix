{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.nixvim = {
    # Set leader key
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      # Disable the spacebar key's default behavior in Normal and Visual modes
      {
        mode = [
          "n"
          "v"
        ];
        key = "<Space>";
        action = "<Nop>";
        options.silent = true;
      }

      # Allow moving the cursor through wrapped lines with j, k
      {
        mode = "n";
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          expr = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          expr = true;
          silent = true;
        };
      }

      # Clear highlights
      {
        mode = "n";
        key = "<Esc>";
        action = ":noh<CR>";
        options.silent = true;
      }

      # Save and quit
      {
        mode = "n";
        key = "<C-s>";
        action = "<cmd> w <CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>sn";
        action = "<cmd>noautocmd w <CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-q>";
        action = "<cmd> q <CR>";
        options.silent = true;
      }

      # Delete single character without copying into register
      {
        mode = "n";
        key = "x";
        action = "\"_x";
        options.silent = true;
      }

      # Vertical scroll and center
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
        options.silent = true;
      }

      # Find and center
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
      }

      # Buffers
      {
        mode = "n";
        key = "<Tab>";
        action = ":bnext<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = ":bprevious<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-i>";
        action = "<C-i>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>x";
        action = ":Bdelete!<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>b";
        action = "<cmd> enew <CR>";
        options.silent = true;
      }

      # Increment/decrement numbers
      {
        mode = "n";
        key = "<leader>+";
        action = "<C-a>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>-";
        action = "<C-x>";
        options.silent = true;
      }

      # Window management
      {
        mode = "n";
        key = "<leader>v";
        action = "<C-w>v";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>h";
        action = "<C-w>s";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>se";
        action = "<C-w>=";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>xs";
        action = ":close<CR>";
        options.silent = true;
      }

      # Navigate between splits
      {
        mode = "n";
        key = "<C-k>";
        action = ":wincmd k<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-j>";
        action = ":wincmd j<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-h>";
        action = ":wincmd h<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-l>";
        action = ":wincmd l<CR>";
        options.silent = true;
      }

      # Tabs
      {
        mode = "n";
        key = "<leader>to";
        action = ":tabnew<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>tx";
        action = ":tabclose<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>tn";
        action = ":tabn<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>tp";
        action = ":tabp<CR>";
        options.silent = true;
      }

      # Toggle line wrapping
      {
        mode = "n";
        key = "<leader>lw";
        action = "<cmd>set wrap!<CR>";
        options.silent = true;
      }

      # Press jk fast to exit insert mode
      {
        mode = "i";
        key = "jk";
        action = "<ESC>";
        options.silent = true;
      }
      {
        mode = "i";
        key = "kj";
        action = "<ESC>";
        options.silent = true;
      }

      # Stay in indent mode
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.silent = true;
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.silent = true;
      }

      # Move text up and down
      {
        mode = "v";
        key = "<A-j>";
        action = ":m .+1<CR>==";
        options.silent = true;
      }
      {
        mode = "v";
        key = "<A-k>";
        action = ":m .-2<CR>==";
        options.silent = true;
      }

      # Keep last yanked when pasting
      {
        mode = "v";
        key = "p";
        action = "\"_dP";
        options.silent = true;
      }

      # Replace word under cursor
      {
        mode = "n";
        key = "<leader>j";
        action = "*``cgn";
      }

      # Explicitly yank to system clipboard
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>y";
        action = "\"+y";
      }
      {
        mode = "n";
        key = "<leader>Y";
        action = "\"+Y";
      }

      # Toggle diagnostics (Converted to Neovim 0.10+ native Lua one-liner)
      {
        mode = "n";
        key = "<leader>do";
        action = "<cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<CR>";
        options = {
          desc = "Toggle diagnostics";
          silent = true;
        };
      }

      # Diagnostic keymaps
      {
        mode = "n";
        key = "[d";
        action = "<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<CR>";
        options.desc = "Go to previous diagnostic message";
      }
      {
        mode = "n";
        key = "]d";
        action = "<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<CR>";
        options.desc = "Go to next diagnostic message";
      }
      {
        mode = "n";
        key = "<leader>d";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options.desc = "Open floating diagnostic message";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>lua vim.diagnostic.setloclist()<CR>";
        options.desc = "Open diagnostics list";
      }

      # Save and load session
      {
        mode = "n";
        key = "<leader>ss";
        action = ":mksession! .session.vim<CR>";
        options.silent = false;
      }
      {
        mode = "n";
        key = "<leader>sl";
        action = ":source .session.vim<CR>";
        options.silent = false;
      }
    ];
  };
}
