{ inputs, config, ... }: {

  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
