{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "starship-eldritch-theme";
  version = "1";

  src = fetchFromGitHub {
    owner = "dragonginger10";
    repo = "eldritch-spaceship";
    rev = "f49406a7e5ba6d4321e945880bf1682920c29be4";
    hash = "sha256-clPMs8sFUx12LOReOT0GeaGeShUAbykZuod9lxGacCE=";
  };

  dontabuild = true;

  postPatch = ''
    rm *.md LICENSE screenshot.png
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp *.toml $out/config.toml
    runHook postInstall
  '';

  meta = with lib; {
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ dragonginger ];
  };
}
