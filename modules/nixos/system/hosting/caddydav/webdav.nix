# webdav.nix
{ config, pkgs, ... }:

{
  systemd.services.rclone-webdav = {
    description = "Rclone WebDAV Server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.rclone}/bin/rclone serve webdav /var/lib/webdav --addr 127.0.0.1:8080";
      Restart = "always";
      User = "caddy";
      Group = "caddy";
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/webdav 0750 caddy caddy -"
  ];

  services.caddy = {
    enable = true;
    extraConfig = ''
      storage.yourdomain.com {
        @options {
            method OPTIONS
        }
        handle @options {
            header Access-Control-Allow-Origin "*" 
            header Access-Control-Allow-Methods "OPTIONS, GET, HEAD, POST, PUT, DELETE, MKCOL, PROPFIND, PROPPATCH, COPY, MOVE, LOCK, UNLOCK"
            header Access-Control-Allow-Headers "Authorization, Content-Type, Depth, Destination, Overwrite, If"
            header Access-Control-Max-Age "86400" 
            respond 204
        }

        header Access-Control-Allow-Origin "*"
        header Access-Control-Expose-Headers "ETag"

        @not_options {
            not method OPTIONS
        }
        basicauth @not_options {
            betty JDJhJDE0JDV2... # Replace with actual bcrypt hash
        }

        reverse_proxy 127.0.0.1:8080
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
