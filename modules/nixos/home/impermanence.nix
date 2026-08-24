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
      ".wine-ableton"

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
      ".config/blender"
      ".config/celestia"
      ".config/inkscape"
      ".config/figma-linux"
      ".config/kitty"
      ".config/goofcord"
      ".config/mango"
      ".config/ncspot"
      ".config/REAPER"
      ".config/spicetify"
      ".config/tmux"
      ".config/zen"
      ".config/zsh"
      ".config/JetBrains"

      # Discord
      ".config/vesktop"

      # .local/share
      ".local/share/direnv"
      ".local/share/nvim"
      ".local/share/TelegramDesktop"
      ".local/share/Zeal"
      ".local/share/zoxide"

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
