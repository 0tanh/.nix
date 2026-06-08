{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.neovim = {
    enable = true;
    plugins = [
      # This bundles nvim-treesitter WITH the specific parsers you need
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

}
