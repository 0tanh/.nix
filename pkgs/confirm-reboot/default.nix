{
  lib,
  stdenv,
  bash,
  coreutils,
  fastfetch,
  # fetchFromGitHub,
  pokemon-colorscripts,
  # python314,
  writeShellApplication,
}:
let
  # pokefetchSrc = fetchFromGitHub {
  #   owner = "aldamd";
  #   repo = "PokeFetch";
  #   rev = "53772bd6d2513ca080de0e53a37051eab9490a3e";
  #   hash = "sha256-2ZZMI68krAGXenr/qElyaDo5LRpP2cCgCRGgqjQC+CM=";
  # };
in
pkgs.writeShellApplication {
  name = "confirm-reboot";
  runtimeInputs = [
    bash
    coreutils
  ];
  text = ''
    read -n1 -r -p "Do you really want to reboot? [y/N] >" response
    response=''${response,,}
    if [[ "$response" =~ ^(yes|y)$ ]]
    then
      reboot
    fi
  '';

}
