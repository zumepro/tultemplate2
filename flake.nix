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
        buildInputs = with pkgs; [ typst gnumake jq xdg-utils zip wget ];
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
            name = "alchemist";
            version = "0.1.8";
            hash = "18ckw65wq7q8ksayp1g86c9j6d9l1kfg9m100q0gddaw7ksqjqqq";
          }
          {
            name = "cetz";
            version = "0.4.1";
            hash = "18xinq5agk6zi0r064l6qg09far170n9965a9z2zznz3zsv1h6is";
          }
          {
            name = "oxifmt";
            version = "1.0.0";
            hash = "0bqc5ahiavjds966a8v5llw9imqqaa43x89ha9dl5nlp51vqmla6";
          }
        ];
        pull_typst_package = pkg: pkgs.stdenv.mkDerivation {
          name = "typst_package-${pkg.name}-${pkg.version}";
          src = fetchTarball {
            url = "https://packages.typst.org/preview/${pkg.name}-${pkg.version}.tar.gz";
            sha256 = pkg.hash;
          };
          installPath = "${pkg.name}/${pkg.version}";
          installPhase = ''
            mkdir -p $out/$installPath
            cp -R . $out/$installPath
          '';
        };
        pull_typst_packages = pkgList: pkgs.stdenv.mkDerivation {
          name = "typst-packages";
          src = null;
          dontUnpack = true;
          buildInputs = builtins.map (pkg: pull_typst_package pkg) pkgList;
          installPhase = ''
            mkdir -p $out/preview
            for input in $buildInputs
            do
              ln -s $input/$(ls $input) $out/preview
            done
          '';
        };
        build_with_targets = id: targets: buildOutputs: typstPkgs: pkgs.stdenv.mkDerivation {
          inherit buildInputs targets buildOutputs;
          name = name + "-" + id;
          src = ./.;
          buildPhase = ''
            ${envSetup}
            ${
              if builtins.length typstPkgs > 0
              then
                "ln -s ${pull_typst_packages typstPkgs} typst_packages"
              else ""
            }
            for target in $targets
            do
              make $target ${
                if builtins.length typstPkgs > 0 then "TYPST_PACKAGES=typst_packages" else ""
              }
            done
          '';
          installPhase = ''
            mkdir $out
            for buildOutput in $buildOutputs
            do
              cp -R $buildOutput $out
            done
          '';
        };
        build = id: targets: typstPkgs: (let
          targetFiles = builtins.map (target: "target/${target}") targets;
        in
          build_with_targets id [targetFiles] [targetFiles] typstPkgs);
      in
      {
        devShell = with pkgs; mkShell {
          inherit buildInputs;
          shellHook = envSetup;
        };
        packages.bundle = build_with_targets "bundle" ["bundle"] ["target/pack/bundle/."] [];
        packages.theses = build "theses" (builtins.map (file: "${file}.pdf") [
          "bp_cs" "bp_en"
          "dp_cs" "dp_en"
          "prj_cs" "prj_en"
          "sp_cs" "sp_en"
          "presentation_cs" "presentation_en"
        ]) typstPkgs;
        packages.pack = build_with_targets "pack" ["pack"] ["target/pack/."] [];
      }
    );
}
