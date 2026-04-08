{
  lib,
  stdenv,
  fetchFromGitHub,
  libx11,
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
    libx11
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp icat $out/bin
    runHook postInstall
  '';
}
