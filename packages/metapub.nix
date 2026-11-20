{
  lib,
  python3Packages,
  fetchFromGitHub,
  nix-update-script,
}:

python3Packages.buildPythonApplication (finalAttrs: {
  pname = "metapub";
  version = "0.5.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "dragonginger10";
    repo = "metapub";
    rev = "v${finalAttrs.version}";
    hash = "sha256-FH3y4Wl6TJutEiYfp6eEU06ZYLHCj7MAifOSPnjstiw=";
  };

  build-system = [
    python3Packages.setuptools
  ];

  dependencies = with python3Packages; [
    ebooklib
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "";
    homepage = "https://github.com/dragonginger10/metapub";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ dragonginger ];
    mainProgram = "metapub";
  };
})
