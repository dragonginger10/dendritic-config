{ lib, config, ... }:
{
  options.nixpkgs.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config.flake.modules.nixos.nix =
    let
      predicate = pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowedUnfreePackages;
    in
    {
      nixpkgs.config.allowUnfreePredicate = predicate;
    };

  config.flake.modules.unfree = config.nixpkgs.allowedUnfreePackages;
}
