{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  environment.persistence."/persist" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
      {
        file = "/etc/sops/age/keys.txt";
        parentDirectory = {
          mode = "u=rwx,g=,o=";
        };
      }
      {
        file = "/etc/ssh/ssh_host_ed25519_key";
        parentDirectory = {
          mode = "u=rwx,g=rx,o=";
        };
      }

      {
        file = "/var/keys/secret_file";
        parentDirectory = {
          mode = "u=rwx,g=,o=";
        };
      }

    ];
  };
}
