{
  pkgs,
  inputs,
  ...
}:
with pkgs;
{
  confirm-reboot = callPackage ./confirm-reboot { };
  pokefetch = callPackage ./pokefetch { };
}
