{
  lib,
  appimageTools,
  fetchurl,
}:

let
  pname = "antra";
  version = "1.1.6";
  src = fetchurl {
    url = "https://github.com/anandprtp/Antra/releases/download/v${version}/Antra-Linux.AppImage";
    hash = "sha256-ZhxNsG5AM584rCVONlxsortDdjLMFmJO79z8Kurhh2Q=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [ webkitgtk_4_1 ];

  meta = {
    description = "Convert music links from streaming services into a local music library";
    homepage = "https://github.com/anandprtp/Antra";
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
    mainProgram = "antra";
    platforms = [ "x86_64-linux" ];
  };
}
