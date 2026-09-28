{
  stdenv,
  requireFile,
  unzip,
  lib,
}:
# SOURCE: https://git.t4t.associates/char/flake/ref/main/blob/packages/berkeley-mono/package.nix
stdenv.mkDerivation {
  pname = "454prod";
  version = "1.0";
  src = ../../assets/fonts/454prod.zip;
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
    # homepage = "https://berkeleygraphics.com/typefaces/berkeley-mono/";
    description = ''
      An 0tanh font inspired by the feeling of listening to rapper 454
    '';
    platforms = platforms.all;
  };
}
