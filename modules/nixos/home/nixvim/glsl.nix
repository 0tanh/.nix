{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.lsp.servers.glslls = {
      enable = true;
    };

    plugins.treesitter = {
      # 2. Add the GLSL parser to your existing Treesitter grammars
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        # ... your other grammars (svelte, java, rust, etc.)
        glsl
      ];
    };
    filetype = {
      extension = {
        vert = "glsl";
        frag = "glsl";
        comp = "glsl";
        geom = "glsl";
        tesc = "glsl";
        tese = "glsl";
      };
    };
  };
}
