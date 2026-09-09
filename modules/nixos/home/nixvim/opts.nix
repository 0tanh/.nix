{
  ...
}:
{
  programs.nixvim = {
    opts = {
      number = true;
      relativenumber = false;
      termguicolors = true;
      cmdheight = 1;
      expandtab = true;
      tabstop = 2;
      shiftwidth = 4;
      softtabstop = 4;
      # Strings
      clipboard = "unnamedplus";
    };

    clipboard = {
      providers.wl-copy.enable = true;
    };
  };
}
