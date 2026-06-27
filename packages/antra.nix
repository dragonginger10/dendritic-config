{
  lib,
  appimageTools,
  fetchurl,
  makeDesktopItem,
  runCommand,
  symlinkJoin,
}:

let
  pname = "antra";
  version = "1.1.6";
  src = fetchurl {
    url = "https://github.com/anandprtp/Antra/releases/download/v${version}/Antra-Linux.AppImage";
    hash = "sha256-ZhxNsG5AM584rCVONlxsortDdjLMFmJO79z8Kurhh2Q=";
  };

  wrapped = appimageTools.wrapType2 {
    inherit pname version src;

    extraPkgs =
      pkgs: with pkgs; [
        webkitgtk_4_1
        libsoup_3
      ];
  };

  iconPkg = runCommand "antra-icon" { } ''
    mkdir -p $out/share/icons/hicolor/128x128/apps
    cp ${
      fetchurl {
        url = "https://raw.githubusercontent.com/anandprtp/Antra/refs/heads/main/antra-wails/build/appicon.png";
        hash = "sha256-3I+X3Q7M+lrdDD2fps2vOZ8GDNzln8vQBv7D8nvaw6s=";
      }
    } $out/share/icons/hicolor/128x128/apps/${pname}.png
  '';

  desktopItem = makeDesktopItem {
    name = pname;
    desktopName = "Antra";
    exec = "antra";
    icon = pname;
    comment = "Convert music links from streaming services into a local music library";
    categories = [
      "AudioVideo"
      "Audio"
    ];
    startupNotify = true;
  };
in
symlinkJoin {
  name = "${pname}-${version}";
  paths = [
    wrapped
    desktopItem
    iconPkg
  ];

  meta = {
    description = "Convert music links from streaming services into a local music library";
    homepage = "https://github.com/anandprtp/Antra";
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
    mainProgram = "antra";
    platforms = [ "x86_64-linux" ];
  };
}
