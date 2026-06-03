{ withSystem, ... }:
{
  flake.overlays.default = _final: prev: {
    local = withSystem prev.stdenv.hostPlatform.system ({ config, ... }: config.packages);
    btop = prev.btop.override { rocmSupport = true; };
  };
}
