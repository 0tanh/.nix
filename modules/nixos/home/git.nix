{
  pkgs,
  lib,
  helpers,
  config,
  user,
  ...
}:
let
  cfg = config;
  usr = config.opts.usr.${user};
  mod = usr.mod.git;

  catpuccin-delta = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "delta";
    rev = "e9e21cffd98787f1b59e6f6e42db599f9b8ab399";
    hash = "sha256-04po0A7bVMsmYdJcKL6oL39RlMLij1lRKvWl5AUXJ7Q=";
  };
in
{
  programs.git = {
    enable = true;
    package = pkgs.git;

    settings = {
      user = {
        email = "0tanh@git.feline.fyi";
        name = "0tanh";
      };
      include = {
        path = "${catpuccin-delta}/catppuccin.gitconfig";
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
      safe = {
        directory = "*";
      };
    };

    lfs.enable = true;
  };

  programs.lazygit = {
    enable = true;
    package = pkgs.lazygit;
    settings = {
      gui = {
        showCommandLog = false;
        nerdFontsVersion = "3";
        spinner = {
          frames = [
            "⡿"
            "⣟"
            "⣯"
            "⣷"
            "⣾"
            "⣽"
            "⣻"
            "⢿"
          ];
          rate = 50;
        };
      };
      git = {
        # paging.pager = "delta --dark --paging=never";
        autoFetch = true;
        parseEmoji = true;
      };
      disableStartupPopups = true;
    };
  };
}
