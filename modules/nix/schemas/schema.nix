{ inputs, ... }:
{
  flake-file.inputs.flake-schemas.url = "github:DeterminateSystems/flake-schemas";

  flake.schemas = inputs.flake-schemas.schemas;
}
