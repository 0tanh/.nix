{
  inputs,
  pkgs,
  config,
  ...
}:
{
  programs = {
    steam = {
      enable = true;
      # Allow wine tricks commands (might be useful)
      protontricks.enable = true;
      # Open firewall for remote play
      remotePlay.openFirewall = true;
    };
  };

  # SOURCE: https://github.com/ValveSoftware/Source-1-Games/issues/5043#issuecomment-1822019817
  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override (
        {
          extraLibraries ? pkgs': [ ],
          ...
        }:
        {
          extraLibraries =
            pkgs':
            (extraLibraries pkgs')
            ++ ([
              pkgs'.gperftools
            ]);
        }
      );
    })
  ];
}
