{ ... }: {
  programs.nixvim.plugins = {
    mini = {
      enable = true;
    };
    mini-animate.enable = true;
  };
}
