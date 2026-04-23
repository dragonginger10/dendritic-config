{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "fastfetch-eldritch";
  version = "0-unstable-2025-10-23";

  src = fetchFromGitHub {
    owner = "eldritch-theme";
    repo = "fastfetch";
    rev = "08ce5cb3768f040bf714b66b78678719eb3303fc";
    hash = "sha256-BAebQYI20YOadHkdIJv+0QKz0BHXuzAtEiOnUUnBEnc=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp config.jsonc $out/config.jsonc
    runHook postInstall
  '';

  meta = {
    description = "A theme for the Ancient Ones! (fastfetch";
    homepage = "https://github.com/eldritch-theme/fastfetch";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ dragonginger ];
    mainProgram = "fastfetch-eldritch";
    platforms = lib.platforms.all;
  };
})
