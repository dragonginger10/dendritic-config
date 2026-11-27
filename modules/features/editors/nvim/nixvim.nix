{ config, lib, ... }:
{
  flake-file.inputs.nixvim = {
    url = lib.mkDefault "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem =
    { inputs', pkgs, ... }:
    {
      packages.neovim = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
        inherit pkgs;
        module = config.flake.modules.nixvim.base;
      };
    };
}
