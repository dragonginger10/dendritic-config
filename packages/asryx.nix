{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "asryx";
  version = "1.1.0";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "rccyx";
    repo = "asryx";
    tag = "v${finalAttrs.version}";
    hash = "sha256-hyygUaIiaI4hdweHAnLD6iyj2+kFF29XrqObuNMGIPc=";
  };

  nativeBuildInputs = [
    cmake
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Daemonless Linux native ASR binary (embedded via whisper.cpp C API, no dependencies beyond the standard C++ and Linux toolchain";
    homepage = "https://github.com/rccyx/asryx";
    changelog = "https://github.com/rccyx/asryx/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ dragonginger ];
    mainProgram = "asryx";
    platforms = lib.platforms.all;
  };
})
