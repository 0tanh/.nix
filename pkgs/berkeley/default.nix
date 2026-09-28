{
  stdenv,
  requireFile,
  unzip,
  lib,
}:
# SOURCE: https://git.t4t.associates/char/flake/ref/main/blob/packages/berkeley-mono/package.nix
stdenv.mkDerivation {
  pname = "berkeley-mono";
  version = "1.0";
  src =
    let
      name = "berkeley-mono-typeface.zip";
    in
    requireFile {
      name = name;
      url = "https://berkeleygraphics.com/typefaces/berkeley-mono/";
      sha256 = "sha256-PRmfxq1DYPbuIMmOie8T6iE26J2V97JEj2/a2OQ1uiw=";
    };
  buildInputs = [ unzip ];
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  pathsToLink = [ "/share/fonts/truetype/" ];
  sourceRoot = ".";
  installPhase = ''
    install_path=$out/share/fonts/truetype
    mkdir -p $install_path
    find -name "BerkeleyMono*.ttf" -exec cp {} $install_path \;
  '';

  meta = with lib; {
    homepage = "https://berkeleygraphics.com/typefaces/berkeley-mono/";
    description = ''
      A love letter to the golden era of computing.
    '';
    platforms = platforms.all;
    licence = licences.unfree;
  };
}
