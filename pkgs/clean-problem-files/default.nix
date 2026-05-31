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
    rm -f /etc/machine-id
    rm -f /etc/sops/age/keys.txt
    rm -f /etc/ssh/ssh_host_ed25519_key
  '';
}
