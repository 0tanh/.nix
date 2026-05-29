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
writeShellApplication {
  name = "pokefetch";
  runtimeInputs = [
    bash
    coreutils
    fastfetch
    pokemon-colorscripts
    # python314
  ];
  text = ''
    pokemon-colorscripts -r --no-title > ~/.cache/pokemon.txt
    clear
    fastfetch --logo ~/.cache/pokemon.txt
  '';
  # python3 ${pokefetchSrc}/pokefetch.py
}
