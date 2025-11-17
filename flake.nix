{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        dependencies = with pkgs; [ typst gnumake jq xdg-utils zip ];
      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = dependencies;
          shellHook = ''
            unset SOURCE_DATE_EPOCH
          '';
        };
      }
    );
}
