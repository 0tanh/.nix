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

    sudo rm -f /etc/machine-id
    sudo rm -f /etc/sops/age/keys.txt
    sudo rm -f /etc/ssh/ssh_host_ed25519_key

    rm -f /home/betty/.config/zsh/.zsh_history.hm-backup
  '';
}
