{
  lib,
  pkgs,
  config,
  ...
}:

let
  cfg = config.radioCfg;
  #  port = config.port;
  #  sourcePassword = config.sourcePassword;
  #  adminPassword = config.adminPassword;
in
{
  imports = [ ./radiocfg.nix ];
  # Reference: https://freestreamhosting.org/how-to-set-up-an-icecast2-server-and-mountpoints/
  # DarkIce: http://darkice.org/
  environment.defaultPackages = with pkgs; [
    darkice # LightWeight audio streaming that connects to ALSA and Jack
    # darksnow # DarkIce with a GUI
  ];
  # My custom darkice config
  #TODO contribute this to nixpkgs
  environment.etc."darkice.cfg".text = ''
    [general]
    duration = 0
    bufferSecs = 5

    [input]
    device = hw:0,0
    sampleRate = 44100
    bitsPerSample = 16
    channel = 2

    [icecast2-0]
    bitrateMode = cbr
    bitrate = 128
    format = mp3
    server = localhost
    port = ${toString cfg.port}
    mountPoint = darkice
    password = ${cfg.sourcePassword}
  '';

}
