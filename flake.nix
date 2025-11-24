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
        build_with_target = target: buildOutput: pkgs.stdenv.mkDerivation {
          inherit buildInputs target buildOutput;
          name = name + "-" + target;
          src = ./.;
          buildPhase = ''
            ${envSetup}
            make $target
          '';
          installPhase = ''
            mkdir $out
            cp -R $buildOutput $out
          '';
        };
        build = target: build_with_target ("target/" + target) ("target/" + target);
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
        in
        {
          packages.documentation = documentation;
          packages.default = merge [documentation] name;
          packages.pack = build_with_target "pack" (builtins.map (v: "target/pack/" + v) [
            "tultemplate2" "tultemplate2.zip"
          ]);
        }
      )
    );
}
