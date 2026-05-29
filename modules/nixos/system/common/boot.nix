{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  boot = {
    loader = {
      # systemd-boot = {
      #   configurationLimit = 3;
      #   enable = true;
      # };
      # efi.canTouchEfiVariables = true;
      # grub = {
      #   enable = true;
      #   efiSupport = vars.efiSupport;
      #   configurationLimit = 3;
      # };
      timeout = lib.mkForce 5; # Hide OS choice for bootloaders
    };

    # Enable "Silent Boot"
    # consoleLogLevel = 0;

    # initrd = {
    #   verbose = false;
    # };

    kernel = {
      # sysctl = {
      #   "fs.file-max" = 2000000000;
      #   "fs.inotify.max_user_instances" = 2000000000;
      # };
    };
    # kernelPackages = pkgs.linuxPackages_latest; # Use the latest kernel https://nixos.wiki/wiki/Linux_kernel
  };
}
