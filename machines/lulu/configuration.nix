# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  # TODO see if this fixes stale rendering bug
  # boot.kernelParams = [ "nouveau.config=NvMSI=0" ];
  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      # zfsSupport = true;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  networking.hostName = "lulu"; # Define your hostname
  networking.hostId = "7e615444"; # run `head -c 8 /etc/machine-id` to get this

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  nixpkgs.config = {
    allowUnfree = true;
  };
  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # don't require sudo passwd as 'wheel' group
  security.sudo.wheelNeedsPassword = false;

  services.tailscale = {
    enable = true;
  };
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "2873fd00f2c32ac1" ];
  };

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    #   enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # NOTE the password here is hashed using SOPS
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.betty = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    hashedPasswordFile = config.sops.secrets."hashedPasswords/betty".path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDJfCNULFgoC3qx8H0xYWT8WHz+TuElEP0LsaN4lOtAl uncia@feline.fyi"
    ];
    packages = with pkgs; [
      neovim
    ];
    shell = pkgs.zsh;
  };

  # programs.firefox.enable = true;
  programs.zsh.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];
  environment.sessionVariables = {
    # Forces Firefox to use the Wayland engine natively
    MOZ_ENABLE_WAYLAND = "1";

    # Tells GTK apps (like Firefox/Chrome) to request screen capture via XDG Portals
    GTK_USE_PORTAL = "1";

    # Forces Chromium, Chrome, and Electron apps to run natively on Wayland
    NIXOS_OZONE_WL = "1";
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
  # Experiment to allow screensharing
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # TODO move these to dedicated packages per window manger
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk # Necessary for the app file-pickers and visual dialogues
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
    config = {
      common = {
        # Fall back to GTK if wlr doesn't handle a specific portal request
        default = [
          "wlr"
          "gtk"
        ];
      };
    };
  };

}
