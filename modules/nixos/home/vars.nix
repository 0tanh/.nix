{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    ELECTRON_OZONE_PLATFORM_HINT = "x11";
    XCURSOR_SIZE = "48";
  };
}
