{
  pkgs,
  inputs,
  config,
  ...
}:
let
  webdav-root = "/var/www/webdav";
in
{
  environment = {
    persistence."/persist" = {
      directories = [
        webdav-root
      ];
    };
  };

  # SOURCE: https://wiki.nixos.org/wiki/Nginx
  services.nginx = {
    enable = true;
    virtualHosts = {
      "contents.0tanh.site" = {
        root = webdav-root;
        locations."/" = {
          davMethods = [
            /**
              Only allow read based requests
            */
            "GET"
            "HEAD"
          ];
          extraConfig = ''
            client_max_body_size 100M;
            auth_basic "Restricted";
            auth_basic_user_file /etc/nginx/.htpasswd;
          '';
        };
      };
    };
  };
}
