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
      # .cache
      ".cache/nvim"

      # .config
      ".config" # do not do this if you can avoid it, this defeats the point of deleting everything

      # .local/share
      ".local/share/direnv"
      ".local/share/nvim"
      ".local/share/TelegramDesktop"
      ".local/share/Zeal"

      # .local/state
      ".local/state/nvim"
    ];
    files = [
      ".config/zsh/.zsh_history"
    ];
  };

}
