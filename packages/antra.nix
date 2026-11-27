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
  version = "2.0.0";
  src = fetchurl {
    url = "https://github.com/anandprtp/Antra/releases/download/v${version}/Antra-Linux.AppImage";
    hash = "sha256-0Mgro92rmaFdOZ4sq58q8/SGUxPUAwIYDlpVoFnqSro=";
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
        # pinned to the release tag; `main` changes and breaks the hash
        url = "https://raw.githubusercontent.com/anandprtp/Antra/v${version}/antra-wails/build/appicon.png";
        hash = "sha256-myj+ZQvDNQL21QcAOAT4ODWz6seZnXeRWTHHsX7MMkE=";
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
