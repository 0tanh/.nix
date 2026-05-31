{
  pkgs,
  inputs,
  ...
}:
with pkgs;
{
  clean-problem-files = callPackage ./clean-problem-files { };
  confirm-reboot = callPackage ./confirm-reboot { };
  pokefetch = callPackage ./pokefetch { };
}
