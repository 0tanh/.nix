{ pkgs, ... }: {

  services.xserver.videoDrivers = [
    # fallback driver
    "fbdev"
    # Make Default Fallback explicit
    "modesetting"
    # Open Source Graphics Driver
    "nouveau"
  ];
  boot = {
    kernelPackages = pkgs.bleeding.linuxPackages_latest;
    kernelParams = [
      # Allow microcode from proprietary NVIDIA drivers
      "nouveau.config=NvGrUseFW=1"
      # Additional fallback parameter
      "nouveau.config=NvMSI=0"
    ];
  };

  hardware = {
    opengl = { };
    enableRedistributableFirmware = true;
    graphics = {
      # Tell NixOS to use the bleeding-edge Mesa packages for 3D acceleration
      package = pkgs.bleeding.mesa.drivers;
      # Enable 32 bit graphics rendering
      enable32Bit = true;
      package32 = pkgs.bleeding.pkgsi686Linux.mesa.drivers;
    };
  };

  environment.sessionVariables = {
    LIBGL_ALWAYS_SOFTWARE = 1;
  };
}
