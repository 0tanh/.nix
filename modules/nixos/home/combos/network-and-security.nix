{
  pkgs,
  lib,
  config,
  ...
}:
{
  # Enable all of these programs
  # programs =
  #   lib.genAttrs
  #     [
  #       # View incoming and outgoing packets
  #       "iftop"
  #       "lsof"
  #       # Network sandboxing
  #       "firejail"
  #       "netstat"
  #     ]
  #     (name: {
  #       enable = true;
  #     });

  home.packages = with pkgs; [
    ghidra
    firejail
  ];
}
