{
  ## NOTE MOST OF THIS WILL NEED TO CHANGE
  disko.devices = {
    disk = {
      root = {
        type = "disk";
        device = "/dev/disk/by-id/ata-APPLE_SSD_SM0128G_S2XUNY0N184605"; # This is the ID of the actual physical disk manufactured.
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "nofail" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };
    };
    zpool = {
      rpool = {
        type = "zpool";
        rootFsOptions = {
          mountpoint = "none";
          compression = "zstd";
          acltype = "posixacl";
          xattr = "sa";
          "com.sun:auto-snapshot" = "false";
        };
        options.ashift = "12";
        datasets = {
          "root" = {
            type = "zfs_fs";
            mountpoint = "/";
          };
          "home" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/home";
          };
          "nix" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/nix";
          };
          "persist" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/persist";
          };

          # # README MORE: https://wiki.archlinux.org/title/ZFS#Swap_volume
          # "root/swap" = {
          #   type = "zfs_volume";
          #   size = "8M";
          #   content = {
          #     type = "swap";
          #   };
          #   options = {
          #     volblocksize = "4096";
          #     compression = "zle";
          #     logbias = "throughput";
          #     sync = "always";
          #     primarycache = "metadata";
          #     secondarycache = "none";
          #     "com.sun:auto-snapshot" = "false";
          #   };
          # };
        };
      };
    };
  };
}
