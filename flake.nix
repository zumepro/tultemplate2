{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        buildInputs = with pkgs; [ typst gnumake jq xdg-utils zip ];
        name = "tultemplate2";
        envSetup = ''
          unset SOURCE_DATE_EPOCH
        '';
        build = target: pkgs.stdenv.mkDerivation {
          inherit buildInputs target;
          name = name + "-" + target;
          src = ./.;
          buildPhase = ''
            ${envSetup}
            make target/$target
          '';
          installPhase = ''
            mkdir $out
            cp target/$target $out
          '';
        };
      in
      {
        devShell = with pkgs; mkShell {
          inherit buildInputs;
          shellHook = envSetup;
        };
      } // (
        with pkgs;
        let
          merge = buildInputs: name: stdenv.mkDerivation {
            inherit name buildInputs;
            dontUnpack = true;
            installPhase = ''
              mkdir $out
              for input in $buildInputs
              do
                cp -R $input/. $out
              done
            '';
          };
          documentation = build "documentation.pdf";
          theses = merge (builtins.map (v: build v) [
              "bp_cs.pdf" "bp_en.pdf"
              "dp_cs.pdf" "dp_en.pdf"
              "prj_cs.pdf" "prj_en.pdf"
              "sp_cs.pdf" "sp_en.pdf"
          ]) (name + "-" + "theses");
        in
        {
          packages.documentation = documentation;
          packages.theses = theses;
          packages.default = merge [documentation theses] name;
        }
      )
    );
}
