{
  lib,
  python314Packages,
  fetchFromGitHub,
  nix-update-script,
}:

python314Packages.buildPythonApplication (finalAttrs: {
  pname = "rogallo";
  version = "3.2.0";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "davep";
    repo = "rogallo";
    tag = "v${finalAttrs.version}";
    hash = "sha256-5YMAhCBj4uhFsaJd+s5hfe9sGHm6kugmsd9x6T5i8YY=";
  };

  build-system = [
    python314Packages.uv-build
  ];

  dependencies = with python314Packages; [
    bagofstuff
    finger2gemtext
    gemtext
    gophermap
    html2gemtext
    md2gemtext
    port1900
    port70
    port79
    pyperclip
    pyyaml
    sybaritic
    textual
    textual-enhanced
    textual-fspicker
    types-pygments
    types-pyperclip
    types-pyyaml
    wasat
    xdg-base-dirs
  ];

  pythonImportsCheck = [
    "rogallo"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A terminal-based client for the small web";
    homepage = "https://github.com/davep/rogallo";
    changelog = "https://github.com/davep/rogallo/blob/${finalAttrs.src.rev}/ChangeLog.md";
    license = with lib.licenses; [
      gpl3Only
      gpl3Plus
    ];
    maintainers = with lib.maintainers; [ ];
    mainProgram = "rogallo";
  };
})
