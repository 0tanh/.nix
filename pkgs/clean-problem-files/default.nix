{
  lib,
  stdenv,
  bash,
  coreutils,
  writeShellApplication,
}:
writeShellApplication {
  name = "clean-problem-files";
  runtimeInputs = [
    bash
    coreutils
  ];
  text = ''
    echo "Deleting orphaned .hm-backup files & problematic files for persisting ..."

    rm -f /home/betty/.config/zsh/.zsh_history.hm-backup
  '';
}
