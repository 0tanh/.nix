{
  lib,
  newScope,
  system,
  stdenv,
  pkgs,
  callPackage,
}:
lib.makeScope newScope (self: {
  dotgrid = callPackage (
    { pkgs, stdenv }:
    stdenv.mkDerivation rec {
      pname = "dotgrid";
      version = "e848fa0e4f5f4826a5b03085106bb37f1e97735b";
      src = pkgs.fetchFromGitHub {
        owner = "hundredrabbits";
        repo = "Dotgrid";
        rev = version;
        sha256 = "1gqx1pbmz2qf2gi98aaifbgw4lksy7yykxnfz3j90zqv9l11dgh6";
      };

      buildInputs = [ pkgs.deno ];
      dontBuild = true;

      installPhase = ''
        mkdir -p $out/lib/dotgrid $out/bin
        cp -r . $out/lib/dotgrid

        # Inject custom main file
        cat ${./Dotgrid.main.js} > $out/lib/dotgrid/main.js

        cat <<EOF > $out/bin/dotgrid
        #!/bin/sh
        cd $out/lib/dotgrid
        exec ${pkgs.deno}/bin/deno run --allow-all main.js "\$@"
        EOF
        chmod +x $out/bin/dotgrid
      '';
    }
  ) { };

  left = callPackage (
    { pkgs, stdenv }:
    stdenv.mkDerivation rec {
      pname = "left";
      version = "f944beea8791c0dcb551f7c61a66b9a1ccefbbe6";
      src = pkgs.fetchFromGitHub {
        owner = "hundredrabbits";
        repo = "Left";
        rev = version;
        sha256 = "1y6xan6k68fdmp95caar75phf8qi9pd2g3ja1608vh6bi8la2yc3";
      };

      buildInputs = [ pkgs.deno ];
      dontBuild = true;

      installPhase = ''
        mkdir -p $out/lib/left $out/bin
        cp -r . $out/lib/left

        cat <<EOF > $out/bin/left
        #!/bin/sh
        cd $out/lib/left/desktop
        exec ${pkgs.deno}/bin/deno run --allow-all main.js "\$@"
        EOF
        chmod +x $out/bin/left
      '';
    }
  ) { };

  orca = callPackage (
    { pkgs, stdenv }:
    stdenv.mkDerivation rec {
      pname = "orca";
      version = "d469077";
      src = pkgs.fetchFromGitHub {
        owner = "hundredrabbits";
        repo = "Orca";
        rev = version;
        sha256 = "0gj78akn0yi9mvg08gi3761bh0dh38bvd5fs7kz35vp8w9szb04s";
      };

      buildInputs = [ pkgs.deno ];
      dontBuild = true;

      installPhase = ''
        mkdir -p $out/lib/orca $out/bin
        cp -r . $out/lib/orca

        cat <<EOF > $out/bin/orca-osc
        #!/bin/sh
        cd $out/lib/orca/desktop
        exec ${pkgs.deno}/bin/deno run --allow-all main.js "\$@"
        EOF
        chmod +x $out/bin/orca-osc
      '';
    }
  ) { };

  marabu = callPackage (
    { pkgs, stdenv }:
    stdenv.mkDerivation rec {
      pname = "marabu";
      version = "e22e203d97af2347c7130e7c4a9c62d4067d5a5a";
      src = pkgs.fetchFromGitHub {
        owner = "hundredrabbits";
        repo = "Marabu";
        rev = version;
        sha256 = "1ynbz269i0hnd35q9jf36kq10lkr294x8719nq0m0f8wd6b5hhcv";
      };

      buildInputs = [ pkgs.deno ];
      dontBuild = true;

      installPhase = ''
        mkdir -p $out/lib/marabu $out/bin
        cp -r . $out/lib/marabu

        cat <<EOF > $out/bin/marabu
        #!/bin/sh
        cd $out/lib/marabu/desktop
        exec ${pkgs.deno}/bin/deno run --allow-all main.js "\$@"
        EOF
        chmod +x $out/bin/marabu
      '';
    }
  ) { };

  pilot = callPackage (
    { pkgs, stdenv }:
    stdenv.mkDerivation rec {
      pname = "pilot";
      version = "3a2afc0ca9d9d09b008de1410b7f08cad92036c6";
      src = pkgs.fetchFromGitHub {
        owner = "hundredrabbits";
        repo = "Pilot";
        rev = version;
        sha256 = "1pd1zgsyfh83lvwnzmn4krnrp0m54aw10253ckjpqkz8j8va84j3";
      };

      buildInputs = [ pkgs.deno ];
      dontBuild = true;

      installPhase = ''
        mkdir -p $out/lib/pilot $out/bin
        cp -r . $out/lib/pilot

        cat <<EOF > $out/bin/pilot-osc
        #!/bin/sh
        cd $out/lib/pilot/desktop
        exec ${pkgs.deno}/bin/deno run --allow-all main.js "\$@"
        EOF
        chmod +x $out/bin/pilot-osc
      '';
    }
  ) { };

  ronin = callPackage (
    { pkgs, stdenv }:
    stdenv.mkDerivation rec {
      pname = "ronin";
      version = "e375668143f8f12b98fa81e3efe7bccae78ce432";
      src = pkgs.fetchFromGitHub {
        owner = "hundredrabbits";
        repo = "Ronin";
        rev = version;
        sha256 = "19mh62fbs2rryrch32cb1jnwckzd731w4131qb921qwz949ygiqf";
      };

      buildInputs = [ pkgs.deno ];
      dontBuild = true;

      installPhase = ''
        mkdir -p $out/lib/ronin $out/bin
        cp -r . $out/lib/ronin

        # Inject custom main file
        cat ${./Ronin.main.js} > $out/lib/ronin/main.js

        cat <<EOF > $out/bin/ronin
        #!/bin/sh
        cd $out/lib/ronin
        exec ${pkgs.deno}/bin/deno run --allow-all main.js "\$@"
        EOF
        chmod +x $out/bin/ronin
      '';
    }
  ) { };
})
