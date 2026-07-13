{
  pkgs,
  lib,
  config,
  ...
}:
{
  # Session variables for this home environment
  home.sessionVariables = {
    EDITOR = "nvim";
    ELECTRON_OZONE_PLATFORM_HINT = "x11";
    XCURSOR_SIZE = "48";
  };
}
