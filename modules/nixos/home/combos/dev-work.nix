{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # This module imports more heavy-weight dev-work modules e.g. IDEs
  # I would like to be able to configure my neovim to work more but eh.
  imports = [

  ];
  home.packages = with pkgs; [
    # Docker for running docker daemons
    docker
    # Intellij IDEA for JVM work
    jetbrains.idea
    # VS Code for more focused editing e.g. of bigger projects e.g. Webbed Sites
    vscode.fhs
    # Offline documentation
    zeal
  ];
}
