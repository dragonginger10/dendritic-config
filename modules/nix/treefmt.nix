{
  self,
  inputs,
  lib,
  ...
}:
{
  flake-file.inputs.treefmt-nix.url = lib.mkDefault "github:numtide/treefmt-nix";
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { pkgs, ... }:
    {
      treefmt.config = {
        projectRootFile = "flake.nix";
        flakeCheck = true;
        programs = {
          nixfmt.enable = true;
        };
      };
    };
}
