{
  pkgs,
  ...
}:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;
    folding.enable = true;
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
