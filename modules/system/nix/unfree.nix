{ lib, config, ... }:
{
  options.nixpkgs.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config = {
    flake = {
      unfree = config.nixpkgs.allowedUnfreePackages;
      modules =
        let
          predicate = pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowedUnfreePackages;
        in
        {
          nixos.nix = {
            nixpkgs.config.allowUnfreePredicate = predicate;
          };
          homeManager.nix = {
            nixpkgs.config.allowUnfreePredicate = predicate;
          };

        };
    };
  };
}
