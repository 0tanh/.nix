{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;

    # Explicitly supply grammar packages
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      svelte
      html
      css
      javascript
      typescript
      rust
      java

    ];

  };

}
