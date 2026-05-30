{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
