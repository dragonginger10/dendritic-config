{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
  unstableGitUpdater,
}:
stdenvNoCC.mkDerivation {
  pname = "plymouth-dracula-theme";
  version = "alpha";

  src = fetchFromGitHub {
    owner = "dracula";
    repo = "plymouth";
    rev = "37aa09b27ecee4a825b43d2c1d20b502e8f19c96";
    hash = "sha256-7YwkBzkAND9lfH2ewuwna1zUkQStBBx4JHGw3/+svhA=";
  };

  postPatch = ''
    rm *.md LICENSE screenshot.png
  '';

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plymouth/themes/dracula
    cp dracula/* $out/share/plymouth/themes/dracula
    find $out/share/plymouth/themes -name \*.plymouth -exec sed -i "s@\/usr\/@$out\/@" {} \;
    runHook postInstall
  '';

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "";
    longDescription = "";

    homepage = "";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ dragonginger ];
  };
}
