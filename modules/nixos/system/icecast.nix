{ config, pkgs, ... }:

{
  # Enable the Icecast service
  services.icecast = {
    enable = true;

    # Set the hostname for stream directory lookups
    hostname = "radio.example.com"; # Change to your domain or IP

    # Set up the administrator credentials
    admin = {
      user = "admin";
      password = ""; # Use a strong password!
    };

    # Configure where Icecast will listen for connections
    listen = {
      address = "0.0.0.0"; # Listen on all IPv4 interfaces. (Default is "::" for IPv6)
      port = 8085;
    };

    # (Optional) Inject custom XML settings into the <icecast> block of the generated icecast.xml
    extraConfig = ''
      <limits>
          <clients>100</clients>
          <sources>2</sources>
          <queue-size>524288</queue-size>
          <client-timeout>30</client-timeout>
          <header-timeout>15</header-timeout>
          <source-timeout>10</source-timeout>
          <burst-on-connect>1</burst-on-connect>
          <burst-size>65535</burst-size>
      </limits>

      <!-- Setting up a source password for clients (like OBS, Mixxx, Butt) to broadcast -->
      <authentication>
          <source-password>MySourcePassword</source-password>
          <relay-password>MyRelayPassword</relay-password>
      </authentication>
    '';
  };

  # Make sure to open the port in the firewall so listeners and source clients can connect
  networking.firewall.allowedTCPPorts = [ 8085 ];
}
