{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  home.persistence."/persist" = {
    directories = [
      "Blog"
      "Code"
      "Downloads"
      "Images"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      {
        directory = ".gnupg";
        mode = "0700";
      }
      {
        directory = ".ssh";
        mode = "0700";
      }
      {
        directory = ".nix";
        mode = "0700";
      }
      {
        directory = ".local/share/keyrings";
        mode = "0700";
      }
      ".cache/nvim"
      ".local/share/direnv"
      ".local/share/nvim"
      ".local/share/TelegramDesktop"
      ".local/state/nvim"
    ];
    files = [
      ".screenrc"
    ];
  };

}
