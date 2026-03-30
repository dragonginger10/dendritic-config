{
  lib,
  stdenv,
  fetchFromGitHub,
  xorg,
  imlib2,
}:
let
  version = "0.5";
in
stdenv.mkDerivation {
  inherit version;
  pname = "icat";

  src = fetchFromGitHub {
    owner = "atextor";
    repo = "icat";
    rev = "v${version}";
    sha256 = "sha256-aiLPVdKSppT/PWPW0Ue475WG61pBLh8OtLuk2/UU3nM=";
  };

  buildInputs = [
    imlib2
    xorg.libX11
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp icat $out/bin
    runHook postInstall
  '';
}
