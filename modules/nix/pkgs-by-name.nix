{
  inputs,
  withSystem,
  ...
}:
{
  flake-file.inputs = {
    pkgs-by-name.url = "github:drupol/pkgs-by-name-for-flake-parts";
    packages = {
      url = "path:./packages";
      flake = false;
    };
  };

  imports = [ inputs.pkgs-by-name.flakeModule ];

  perSystem =
    { config, system, ... }:
    {
      pkgsDirectory = inputs.packages;
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            local = config.packages;
          })
        ];
      };
    };

  flake.overlays.default = _final: prev: {
    local = withSystem prev.stdenv.hostPlatform.system ({ config, ... }: config.packages);
  };
}
