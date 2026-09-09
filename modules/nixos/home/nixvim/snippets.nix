{
  ...
}:
{
  programs.nixvim = {
    /**
            diagnostic = {
              underline = false;
              update_in_insert = true;

              float = {
                source = "always";
              };

              virtual_text = {
                prefix = "●";
                # Use __raw to inject Lua functions directly into the configuration
                format = {
                  __raw = ''
      	    function(diagnostic)
      	      local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ""
      	      return string.format('%s %s', code, diagnostic.message)
      	    end
      	  '';
                };
              };

              signs = {
                text = {
                  __raw = ''
      	    {
      	      [vim.diagnostic.severity.ERROR] = ' ',
      	      [vim.diagnostic.severity.WARN] = ' ',
      	      [vim.diagnostic.severity.INFO] = ' ',
      	      [vim.diagnostic.severity.HINT] = '󰌵 ',
      	    }
      	   '';
                };
              };
            };
    */

    # 2. Autocmds and Augroups (Yank highlight & Kitty padding)
    autoGroups = {
      YankHighlight = {
        clear = true;
      };
      kitty_mp = {
        clear = true;
      };
    };

    autoCmd = [
      # Highlight on yank
      {
        event = "TextYankPost";
        group = "YankHighlight";
        pattern = "*";
        callback = {
          __raw = "function() vim.highlight.on_yank() end";
        };
      }
      # Kitty terminal padding - VimLeave
      {
        event = "VimLeave";
        group = "kitty_mp";
        pattern = "*";
        command = "silent !kitty @ set-spacing padding=default margin=default";
      }
      # Kitty terminal padding - VimEnter
      {
        event = "VimEnter";
        group = "kitty_mp";
        pattern = "*";
        command = "silent !kitty @ set-spacing padding=0 margin=0 3 0 3";
      }
    ];

    # 3. Custom settings that don't map to a specific Nixvim module
    extraConfigLua = ''
      	      -- Prevent LSP from overwriting treesitter color settings
      	      vim.hl.priorities.semantic_tokens = 95
      	      
      	      -- Make diagnostic background transparent
      	      vim.cmd('highlight DiagnosticVirtualText guibg=NONE')
      	    '';

  };
}
