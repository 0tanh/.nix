{ pkgs, inputs, ... }: {
  imports = [
    ./nginx.nix
    ./caddydav
  ];
}
