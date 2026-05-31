{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  virtualisation = {
    # docker = {
    #   enable = true;
    #   # rootless = {
    #   #   enable = true;
    #   #   setSocketVariable = true;
    #   # };
    # };
    libvirtd = {
      enable = true;
      allowedBridges = [
        "virbr0"
        "br0"
      ];
      qemu = {
        package = pkgs.stable.qemu;
        swtpm = {
          enable = false;
        };
      };
    };
    spiceUSBRedirection.enable = true;
    # virtualbox.host = {
    #   enable = true;
    #   enableExtensionPack = true;
    # };
  };

  users.users.betty.extraGroups = [
    "libvirtd"
    "docker"
    "kvm"
  ];
  services.spice-vdagentd.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    dnsmasq
    freerdp
    # gnome-boxes
    # gst_all_1.gst-plugins-good
    # phodav
    quickemu
    # winboat
  ];
}
