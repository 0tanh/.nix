{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  boot.initrd.systemd = {
    enable = true;
    # https://discourse.nixos.org/t/systemd-stage-1-migration/77113/2
    # https://blog.decent.id/post/nixos-systemd-initrd/
    services.rollback = {
      description = "Rollback ZFS root to blank installation for impermanence";

      # Specify dependencies explicitly
      unitConfig.DefaultDependencies = false;
      requiredBy = [ "initrd.target" ]; # This service is required for boot to succeed
      requires = [ "zfs-import-rpool.service" ]; # Wait until the ZFS pool is available
      before = [ "sysroot.mount" ]; # Should complete before any file systems are mounted
      after = [ "zfs-import-rpool.service" ];

      # The script needs to run to completion before this service is done
      serviceConfig = {
        Type = "oneshot";
        # NOTE: to be able to see errors in your script do this:
        # StandardOutput = "journal+console";
        # StandardError = "journal+console";
      };

      script = ''
        ${config.boot.zfs.package}/sbin/zfs rollback -r rpool/root@blank
        ${config.boot.zfs.package}/sbin/zfs rollback -r rpool/home@blank
      '';
    };
  };

  environment.sessionVariables = {
    SOPS_AGE_KEY_FILE = config.sops.age.keyFile;
  };

  environment.persistence."/persist" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/zerotier-one/"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      # "/etc/machine-id"
      {
        file = "/etc/sops/age/keys.txt";
        parentDirectory = {
          user = "root";
          group = "wheel";
          mode = "u=rwx,g=rx,o=";
        };
      }
      # {
      #   file = "/etc/ssh/ssh_host_ed25519_key";
      #   parentDirectory = {
      #     mode = "u=rwx,g=rx,o=";
      #   };
      # }
      {
        file = "/var/keys/secret_file";
        parentDirectory = {
          mode = "u=rwx,g=,o=";
        };
      }
    ];
  };
}
