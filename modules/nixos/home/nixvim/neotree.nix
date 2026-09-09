{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    closeIfLastWindow = true;

    enableDiagnostics = true;
    enableGitStatus = true;
    enableModifiedMarkers = true;
    enableRefreshOnWrite = true;

    window = {
      position = "left";
      width = 30;
      autoExpandWidth = false;
    };

    # Set default Git/File icons (these pair well with Catppuccin)
    defaultComponentConfigs = {
      indent = {
        withExpanders = true;
        expanderCollapsed = "";
        expanderExpanded = "";

      };
    };
  };

}
