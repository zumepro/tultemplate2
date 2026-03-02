{ pkgs }:
let
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
  pull_typst_packages = name: pkgList: pkgs.stdenv.mkDerivation {
    name = name;
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
in
{
  typstPackages = { name, packages }: pull_typst_packages name packages;
  compileDocument = { name, packages, src, fontPath }: pkgs.stdenv.mkDerivation {
    inherit name;
    src = ./.;
    dontUnpack = true;
    buildPhase = ''
      unset SOURCE_DATE_EPOCH
      ${pkgs.typst}/bin/typst \
        compile $src/${src} \
        --font-path $src/${fontPath} \
        --package-path ${pull_typst_packages (name + "-packages") packages} \
        -f pdf $out
    '';
  };
}
