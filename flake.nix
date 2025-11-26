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
      }
    );
}
