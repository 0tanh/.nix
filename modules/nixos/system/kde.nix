{ inputs, config, ... }: {

  # Janky kde add
  services = {
    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.plasma-login-manager.enable = true;
  };
  # services.desktopManager.plasma6.enable = true;
}
