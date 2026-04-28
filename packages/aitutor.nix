{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "aitutor";
  version = "0.1.8";

  src = fetchFromGitHub {
    owner = "naorpeled";
    repo = "aitutor";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Oq4Z9xUgUDbv7KhluCRS9do5khosJpnCWGl6dvdDaTE=";
  };

  vendorHash = "sha256-P3iFBhlDRS+bTfGRwy2bTPmi83HgIOMPKI364SRUouI=";

  ldflags = [
    "-s"
    "-w"
    "-X=main.version=${finalAttrs.version}"
  ];

  meta = {
    description = "Vimtutor like guide for AI";
    homepage = "https://github.com/naorpeled/aitutor";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "aitutor";
  };
})
