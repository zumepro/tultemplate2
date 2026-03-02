{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    much_pdf_tools.url = "git+https://git.zumepro.cz/ondrej.mekina/much_pdf_tools.git";
  };

  outputs = { self, nixpkgs, utils, much_pdf_tools }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        buildInputs = with pkgs; [ pkgs.typst gnumake jq xdg-utils zip wget ];
        name = "tultemplate2";
        envSetup = ''
          unset SOURCE_DATE_EPOCH
          LIB=template/lib
          if [ ! -e $LIB ]; then mkdir $LIB; fi
          if [ ! -e $LIB/much_pdf_tools ]
          then
            cp -R ${much_pdf_tools.packages.${system}.much_pdf_tools} $LIB/much_pdf_tools
            chmod +w $LIB/much_pdf_tools
          fi
        '';
        typstPkgs = [
          {
            name = "fletcher";
            version = "0.5.8";
            hash = "1mcff87a16y24rx8yflrg55ry08sbdfw2cvw7shjkqjl64vs4alj";
          }
          {
            name = "cetz";
            version = "0.3.4";
            hash = "1nxgrpghgfnvijf6647ix6q8njbxbj2hsg7rs2i9air5i5iw9waj";
          }
          {
            name = "oxifmt";
            version = "0.2.1";
            hash = "0v4x0d7c8593scfj4n70q6wv8b5k6d725isf0yd2wzkphzgrhpha";
          }
        ];
        typst = (import ./typst.nix) { inherit pkgs; };
      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = buildInputs ++ [ (pkgs.stdenv.mkDerivation {
            name = name + "-typstfmt";
            dontUnpack = true;
            installPhase = ''
              mkdir -p $out/bin
              ln -s ${typstyle}/bin/typstyle $out/bin/typstyle
              ln -s ${writeShellScript "tultypstfmt" ''
                typstyle --inplace -l 100 $@
              ''} $out/bin/ttfmt
            '';
          }) ];
          shellHook = envSetup;
        };
        packages.minimal = pkgs.stdenv.mkDerivation {
          name = "tultemplate2-minimal";
          src = ./.;
          buildInputs = with pkgs; [ zip jq ];
          buildPhase = ''
            ${envSetup}
            ${pkgs.gnumake}/bin/make minimal
          '';
          installPhase = ''
            mkdir $out
            cp -R target/pack/minimal/. $out
          '';
        };
        packages.documentation = pkgs.stdenv.mkDerivation {
          name = "tultemplate2-documentation";
          src = ./.;
          dontInstall = true;
          buildPhase = ''
            ${envSetup}
            mkdir $out
            ln -s ${typst.compileDocument {
              name = name + "-cs";
              packages = typstPkgs;
              src = "documentation_cs.typ";
              fontPath = "template/fonts";
            }} $out/documentation_cs.pdf
            ln -s ${typst.compileDocument {
              name = name + "-en";
              packages = typstPkgs;
              src = "documentation_en.typ";
              fontPath = "template/fonts";
            }} $out/documentation_en.pdf
          '';
        };
        packages.llms = pkgs.stdenv.mkDerivation {
          name = name + "-llms";
          src = ./llms;
          installPhase = ''
            mkdir $out
            cp -r $src/. $out
          '';
        };
      }
    );
}
