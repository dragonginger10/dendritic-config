{ fetchFromGitHub, buildGoModule }:
let
  pname = "glazepkg";
  version = "0.3.21";
in
buildGoModule {
  inherit pname version;
  src = fetchFromGitHub {
    repo = pname;
    owner = "neur0map";
    tag = "v${version}";
    hash = "sha256-Ct1AXt/p4xxhRm6D5XYYI/WP8O5VluXS3nnNJkf60sM=";
  };
  vendorHash = "sha256-XBUNzZWZa1weyC7PhSeBDjcymNQaxV7jXOIkN6sDwQ0=";
}
