{ inputs, ... }:
{
  config = {
    flake-file.inputs.flake-schemas.url = "github:DeterminateSystems/flake-schemas";
    flake.schemas = inputs.flake-schemas.schemas;
  };

  options = {
    flake = inputs.flake-parts.lib.mkSubmoduleOptions {
      schemas = inputs.nixpkgs.lib.mkOption {
        default = { };
      };
    };
  };
}
