{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      devenv
    ]
    ++ [
      (pkgs.writeShellScriptBin "init-devenv" ''
        devenv init
             cat << "EOF" > .envrc
             #!/usr/bin/env bash
             export DIRENV_WARN_TIMEOUT=20s
             eval "$(devenv direnvrc)"
             use devenv
             EOF	
      '')
    ];
}
