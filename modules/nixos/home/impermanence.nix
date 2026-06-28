{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  # Directories in here persist after reboot.
  # Ensure that only things you really care about are in here,
  # and that you keep the contents of these directories backed up.
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
      # profile pic
      # ".face"
    ];
  };

}
