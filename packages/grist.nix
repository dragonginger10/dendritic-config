{
  lib,
  appimageTools,
  fetchurl,
  makeDesktopItem,
  symlinkJoin,
}:

let
  pname = "grist";
  version = "0.3.12";
  src = fetchurl {
    url = "https://github.com/gristlabs/grist-desktop/releases/download/v${version}/grist-desktop-${version}-linux-x86_64.AppImage";
    hash = "sha256-p111GXd5MkvzVaEXlj+YGrFBZABjgJEIsLrr/BH52p0=";
  };

  wrapped = appimageTools.wrapType2 {
    inherit pname version src;
  };

  desktopItem = makeDesktopItem {
    name = pname;
    desktopName = "Grist";
    exec = "grist";
    comment = "Modern relational spreadsheet with a Python data engine";
    categories = [
      "Office"
      "Database"
    ];
    startupNotify = true;
  };
in
symlinkJoin {
  name = "${pname}-${version}";
  paths = [
    wrapped
    desktopItem
  ];

  meta = {
    description = "Modern relational spreadsheet with a Python data engine";
    homepage = "https://github.com/gristlabs/grist-desktop";
    license = lib.licenses.asl20;
    maintainers = [ ];
    mainProgram = "grist";
    platforms = [ "x86_64-linux" ];
  };
}
