{
  lib,
  pkgs,
  inputs, # TODO hash real passwords for irl deployment and not localhost nonsense
  config,
  ...
}:
# DOCS: https://icecast.org/docs/icecast-trunk/config_file/
# Reference: https://freestreamhosting.org/how-to-set-up-an-icecast2-server-and-mountpoints/
let
  cfg = config.radioCfg;
  # port = config.radiocfg.port;
  # sourcePassword = config.radiocfg.sourcePassword;
  # adminPassword = config.radiocfg.adminPassword;
in
{

  imports = [ ./radiocfg.nix ]; # Shared radio config info for darkice and icecast

  # Make sure to open the port in the firewall so listeners and source clients can connect
  networking.firewall.allowedTCPPorts = [ cfg.port ];
  # Enable the icecast.nixcast service
  services.icecast = {
    enable = true;

    # Set the hostname for stream directory lookups
    hostname = ""; # Change to your domain or IP

    # Set up the administrator credentials
    admin = {
      user = "admin";
      password = cfg.adminPassword; # Use a strong password!
    };

    # Configure where Icecast will listen for connections
    listen = {
      address = "0.0.0.0"; # Listen on all IPv4 interfaces. (Default is "::" for IPv6)
      port = cfg.port;
    };

    # (Optional) Inject custom XML settings into the <icecast> block of the generated icecast.xml
    extraConfig = lib.strings.concatLines [
      ''
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
      ''
      # Mount point config goes here
      ''
        <mount type="default">

            <bitrate>64</bitrate>
            <type>application/ogg</type>
            <subtype>vorbis</subtype>
            <charset>ISO8859-1</charset>
            
            <mount-name>/bett-mixxx.ogg</mount-name>
            
            <username>betmix</username>
            <password>hackmemore</password>
            
            <public>1</public>
        </mount>
      ''

      ''
        <mount type="normal">
            <mount-name>/lofi.ogg</mount-name>
            <max-listeners>50</max-listeners>
            <fallback-mount>/lofi-fallback.ogg</fallback-mount>
            <fallback-override>1</fallback-override>
            <public>1</public>
        </mount>
      ''
      #Authentication config goes here
      ''
        <!-- Setting up a source password for clients (like OBS, Mixxx, Butt) to broadcast -->
        <authentication>
            <source-password>${cfg.sourcePassword}</source-password>
            <relay-password>relay</relay-password>
        </authentication>
      ''
    ];
  };

}
