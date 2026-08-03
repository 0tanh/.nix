{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{

  programs.pet = {
    enable = true;
    settings = {
      general = {
        editor = "nvim";
        cmd = [
          "zsh"
          "-c"
        ];
        color = true;
      };
    };

    snippets = [
      {
        description = "Convert all M4A files to MP3 files";
        command = "for file in ./**/*.m4a; do; ffmpeg -i \"$file\" -b:a 320k \"$file.mp3\"; done";
      }
      {
        description = "Generate age key from a private SSH key";
        command = "export SSH_TO_AGE_PASSPHRASE='password' && nix run nixpkgs#ssh-to-age -- -private-key -i ~/.ssh/uncia.id_ed25519 > ~/.config/sops/age/keys.txt";
      }
      {
        description = "Derive a public age key from the private age key";
        command = "nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt";
      }
      {
        description = "Derive a public SSH key from a private SSH key";
        command = "ssh-keygen -f ~/.ssh/uncia.id_ed25519 -y > ~/.ssh/uncia.id_ed25519.pub";
      }
      {
        description = "Copy an SSH key to a target machine";
        command = "ssh-copy-id -i ~/.ssh/uncia.id_ed25519 target";
      }
      {
        command = "git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*' && git fetch && git for-each-ref --format='%(refname:short)' refs/heads | xargs git branch -D";
        description = "Fix a git bare worktree's refs.";
      }
      {
        command = ''
          git config credential.helper '!f() { sleep 1; echo \"username=''${GIT_USER}\"; echo \"password=''${GIT_PASSWORD}\"; }; f'
        '';
        description = "Set up a local credential helper for git to use the GIT_USER and GIT_PASSWORD env variables for auth.";
      }
    ];
  };
}
