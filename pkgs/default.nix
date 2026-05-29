{
  pkgs,
  inputs,
  ...
}:
{
  pokefetch = pkgs.callPackage ./pokefetch { };
}
