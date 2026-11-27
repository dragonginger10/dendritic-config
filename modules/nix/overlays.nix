{ config, withSystem, ... }:
let
  overlays = [ config.flake.overlays.default ];
in
{
  flake.overlays.default = _final: prev: {
    local = withSystem prev.stdenv.hostPlatform.system ({ config, ... }: config.packages);
    btop = prev.btop.override { rocmSupport = true; };
  };

  flake.modules = {
    nixos.nix.nixpkgs = { inherit overlays; };
    homeManager.nix.nixpkgs = { inherit overlays; };
  };
}
