{
  lib,
  stdenv,
  bash,
  coreutils,
  writeShellApplication,
}:
writeShellApplication {
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
