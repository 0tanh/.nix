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
      "Windows"

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

      # profile pic
      ".face"

      # .config
      ".config/inkscape"
      ".config/zen"
      ".config/tmux"
      ".config/mango"
      ".config/zsh"
      ".config/kitty"
      ".config/celestia"

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
