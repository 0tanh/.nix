{
  disko.devices = {
    disk = {
      root = {
        type = "disk";
        # TODO get this ID
        device = "/dev/disk/by-id/nvme-HFM512GD3GX013N-SKhynix_FYB6N009010406768";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "nofail" ];
              };
            };
            swap = {
              size = "4G";
              content = {
                type = "swap";
                # Clear the swap at startup and when a sector is freed.
                discardPolicy = "both";
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
          acltype = "posixacl";
          atime = "off";
          compression = "zstd";
          mountpoint = "none";
          xattr = "sa";
          "com.sun:auto-snapshot" = "false";
        };
        options.ashift = "12";
        postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^rpool/root@blank$' || ( zfs snapshot rpool/root@blank ; zfs snapshot rpool/home@blank ; zfs snapshot rpool/nix@blank )";
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
        };
      };
    };
  };
}
