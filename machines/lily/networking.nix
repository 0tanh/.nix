{
  pkgs,
  inputs,
  config,
  ...
}:
let
  interface = "wlp3s0";
in
{

  # Configure network connections interactively with nmcli or nmtui.
  networking = {

    networkmanager.enable = true;
    interfaces.${interface}.ipv4.addresses = [
      {
        address = "10.223.227.137";
        prefixLength = 24;
      }
    ];

    defaultGateway = {
      address = "192.0.2.1";
      interface = interface;
    };

    # Servers that names will resolve to
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];

    usePredictableInterfaceNames = true;
    # Static IP address info

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
