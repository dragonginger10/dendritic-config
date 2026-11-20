{
  lib,
  stdenv,
  fetchFromGitHub,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "desko";
  version = "0-unstable-2026-08-05";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "typewriter03";
    repo = "Desko";
    rev = "c50ad54586bdb684171ce9e2d52ad047c816fd68";
    hash = "sha256-GIQvUWeDtr5pc6a71upSack6GCFwEWDMPk2lhC7WY2M=";
  };

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Make use of your old phone || Your own Desk Buddy";
    homepage = "https://github.com/typewriter03/Desko";
    maintainers = with lib.maintainers; [ ];
    mainProgram = "desko";
    platforms = lib.platforms.all;
  };
})
