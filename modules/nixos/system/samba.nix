{
  pkgs,
  config,
  ...
}:
let
  options = [
    "uid=1000000"
    "gid=1000000"
    "file_mode=0666"
    "dir_mode=0777"
    "credentials=${config.sops.templates."share-felinefyi-credentials".path}"
    "x-systemd.automount"
    "noauto"
    "nofail"
  ];
  shareFelineFyiIPv4 = "10.223.227.14"; # Update this with latest zerotier remote IP.
in
{
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  fileSystems = {
    "/mnt/share-felinefyi" = {
      device = "//${shareFelineFyiIPv4}/share";
      fsType = "cifs";
      inherit options;
    };
  };

  sops = {
    secrets = {
      share-felinefyi-password = {
        key = "credentials/passwords/share-felinefyi";
      };
    };
    templates."share-felinefyi-credentials" = {
      content = ''
        username=trusted
        password=${config.sops.placeholder.share-felinefyi-password}
      '';
    };
  };
}
