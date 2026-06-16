{ inputs, config, ... }:
let
  secretsPath = builtins.toString inputs.secrets;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${secretsPath}/secrets.yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/home/betty/.ssh/id_ed25519"
      ];
      keyFile = "/etc/sops/age/keys.txt";
      generateKey = false;
    };

    secrets = {
      "hashedPasswords/betty" = {
        neededForUsers = true;
      };
    };
  };
}
